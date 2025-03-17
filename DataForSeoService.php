<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class DataForSeoService
{
    protected $login;
    protected $password;
    
    public function __construct()
    {
        $this->login = config('services.dataforseo.login');
        $this->password = config('services.dataforseo.password');
    }
    
    public function checkRanking($keyword, $domain, $location, $language)
    {
        $url = 'https://api.dataforseo.com/v3/serp/google/organic/live/regular';
        
        $data = [[
            "keyword" => $keyword,
            "location_code" => $location,
            "language_code" => $language,
            "depth" => 100
        ]];
        
        try {
            $response = Http::withBasicAuth($this->login, $this->password)
                ->withHeaders(['Content-Type' => 'application/json'])
                ->post($url, $data)
                ->json();
            
            Log::info('DataForSEO Response', ['response' => $response]);
            
            // Verificar respuesta
            if (!isset($response['status_code']) || $response['status_code'] != 20000) {
                throw new \Exception($response['status_message'] ?? 'Error en la API de DataForSEO');
            }
            
            // Buscar posición del dominio
            $items = $response['tasks'][0]['result'][0]['items'] ?? [];
            $position = 0;
            $matchingUrl = '';
            
            foreach ($items as $index => $item) {
                if (isset($item['url']) && strpos($item['url'], $domain) !== false) {
                    $position = $index + 1;
                    $matchingUrl = $item['url'];
                    break;
                }
            }
            
            return [
                'success' => true,
                'position' => $position,
                'url' => $matchingUrl
            ];
        } catch (\Exception $e) {
            Log::error('DataForSEO API Error: ' . $e->getMessage());
            return [
                'success' => false,
                'error' => 'api_error',
                'message' => $e->getMessage()
            ];
        }
    }
}
