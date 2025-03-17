LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=rank_tracker_api
DB_USERNAME=rankuser
DB_PASSWORD=SNDU438jsuhs736YH

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

DATAFORSEO_LOGIN=contacto@seobyleo.com
DATAFORSEO_PASSWORD=bee53869a8810767
EOL

# Optimizar la configuración
cd /var/www/api.ranktracker.tech
php artisan config:cache
php artisan route:cache
# Implementar modelo Plan
cat > /var/www/api.ranktracker.tech/app/Models/Plan.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use HasFactory;
    
    protected $fillable = ['name', 'daily_limit', 'price'];
    
    public function licenses()
    {
        return $this->hasMany(License::class);
    }
}
EOL

# Implementar modelo License
cat > /var/www/api.ranktracker.tech/app/Models/License.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class License extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_key', 'plan_id', 'domain', 'is_active', 'expires_at'];
    
    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }
    
    public function usages()
    {
        return $this->hasMany(ApiUsage::class);
    }
    
    // Verificar si la licencia está activa y no expirada
    public function isValid()
    {
        return $this->is_active && 
               ($this->expires_at === null || $this->expires_at > now());
    }
    
    // Generar una clave de licencia única
    public static function generateKey()
    {
        $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8));
               
        // Verificar que la clave no exista ya
        while (self::where('license_key', $key)->exists()) {
            $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8));
        }
        
        return $key;
    }
}
EOL

# Implementar modelo ApiUsage
cat > /var/www/api.ranktracker.tech/app/Models/ApiUsage.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiUsage extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_id', 'usage_date', 'usage_count'];
    
    public function license()
    {
        return $this->belongsTo(License::class);
    }
}
EOL

# Implementar modelo Plan
cat > /var/www/api.ranktracker.tech/app/Models/Plan.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use HasFactory;
    
    protected $fillable = ['name', 'daily_limit', 'price'];
    
    public function licenses()
    {
        return $this->hasMany(License::class);
    }
}
EOL

# Implementar modelo License
cat > /var/www/api.ranktracker.tech/app/Models/License.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class License extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_key', 'plan_id', 'domain', 'is_active', 'expires_at'];
    
    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }
    
    public function usages()
    {
        return $this->hasMany(ApiUsage::class);
    }
    
    // Verificar si la licencia está activa y no expirada
    public function isValid()
    {
        return $this->is_active && 
               ($this->expires_at === null || $this->expires_at > now());
    }
    
    // Generar una clave de licencia única
    public static function generateKey()
    {
        $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8));
               
        // Verificar que la clave no exista ya
        while (self::where('license_key', $key)->exists()) {
            $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8));
        }
        
        return $key;
    }
}
EOL

# Implementar modelo ApiUsage
cat > /var/www/api.ranktracker.tech/app/Models/ApiUsage.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiUsage extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_id', 'usage_date', 'usage_count'];
    
    public function license()
    {
        return $this->belongsTo(License::class);
    }
}
EOL

# Implementar modelo Plan
cat > /var/www/api.ranktracker.tech/app/Models/Plan.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use HasFactory;
    
    protected $fillable = ['name', 'daily_limit', 'price'];
    
    public function licenses()
    {
        return $this->hasMany(License::class);
    }
}
EOL

# Implementar modelo License
cat > /var/www/api.ranktracker.tech/app/Models/License.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class License extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_key', 'plan_id', 'domain', 'is_active', 'expires_at'];
    
    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }
    
    public function usages()
    {
        return $this->hasMany(ApiUsage::class);
    }
    
    // Verificar si la licencia está activa y no expirada
    public function isValid()
    {
        return $this->is_active && 
               ($this->expires_at === null || $this->expires_at > now());
    }
    
    // Generar una clave de licencia única
    public static function generateKey()
    {
        $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8));
               
        // Verificar que la clave no exista ya
        while (self::where('license_key', $key)->exists()) {
            $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8));
        }
        
        return $key;
    }
}
EOL

# Implementar modelo ApiUsage
cat > /var/www/api.ranktracker.tech/app/Models/ApiUsage.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiUsage extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_id', 'usage_date', 'usage_count'];
    
    public function license()
    {
        return $this->belongsTo(License::class);
    }
}
EOL

cat > /var/www/api.ranktracker.tech/app/Models/Plan.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use HasFactory;
    
    protected $fillable = ['name', 'daily_limit', 'price'];
    
    public function licenses()
    {
        return $this->hasMany(License::class);
    }
}
EOL

# Crear el directorio Models si no existe
mkdir -p /var/www/api.ranktracker.tech/app/Models
# Modelo Plan
cat > /var/www/api.ranktracker.tech/app/Models/Plan.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use HasFactory;
    
    protected $fillable = ['name', 'daily_limit', 'price'];
    
    public function licenses()
    {
        return $this->hasMany(License::class);
    }
}
EOL

ls -l /var/www/api.ranktracker.tech/app/Models/Plan.php
cat /var/www/api.ranktracker.tech/app/Models/Plan.php
cat > /var/www/api.ranktracker.tech/app/Models/License.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class License extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_key', 'plan_id', 'domain', 'is_active', 'expires_at'];
    
    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }
    
    public function usages()
    {
        return $this->hasMany(ApiUsage::class);
    }
    
    // Verificar si la licencia está activa y no expirada
    public function isValid()
    {
        return $this->is_active && 
               ($this->expires_at === null || $this->expires_at > now());
    }
    
    // Generar una clave de licencia única
    public static function generateKey()
    {
        $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
               substr(md5(uniqid(rand(), true)), 0, 8));
               
        // Verificar que la clave no exista ya
        while (self::where('license_key', $key)->exists()) {
            $key = strtoupper(substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8) . '-' . 
                   substr(md5(uniqid(rand(), true)), 0, 8));
        }
        
        return $key;
    }
}
EOL

cat > /var/www/api.ranktracker.tech/app/Models/ApiUsage.php << 'EOL'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiUsage extends Model
{
    use HasFactory;
    
    protected $fillable = ['license_id', 'usage_date', 'usage_count'];
    
    public function license()
    {
        return $this->belongsTo(License::class);
    }
}
EOL

ls -l /var/www/api.ranktracker.tech/app/Models/
# Crear las migraciones para cada tabla
cd /var/www/api.ranktracker.tech
php artisan make:migration create_plans_table --create=plans
php artisan make:migration create_licenses_table --create=licenses
php artisan make:migration create_api_usages_table --create=api_usages
# Obtener los nombres exactos de los archivos de migración
PLANS_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_plans_table.php | head -1)
LICENSES_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_licenses_table.php | head -1)
API_USAGES_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_api_usages_table.php | head -1)
# Mostrar los nombres para confirmación
echo "Plans migration: $PLANS_MIGRATION"
echo "Licenses migration: $LICENSES_MIGRATION"
echo "API Usages migration: $API_USAGES_MIGRATION"
# Editar migración de plans
cat > /var/www/api.ranktracker.tech/database/migrations/2025_03_16_172152_create_plans_table.php << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('plans', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('daily_limit');
            $table->decimal('price', 8, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plans');
    }
};
EOL

# Editar migración de licenses
cat > /var/www/api.ranktracker.tech/database/migrations/2025_03_16_172152_create_licenses_table.php << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('licenses', function (Blueprint $table) {
            $table->id();
            $table->string('license_key')->unique();
            $table->foreignId('plan_id')->constrained();
            $table->string('domain')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('licenses');
    }
};
EOL

# Editar migración de api_usages
cat > /var/www/api.ranktracker.tech/database/migrations/2025_03_16_172152_create_api_usages_table.php << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('api_usages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('license_id')->constrained();
            $table->date('usage_date');
            $table->integer('usage_count')->default(0);
            $table->timestamps();
            $table->unique(['license_id', 'usage_date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('api_usages');
    }
};
EOL

# Ejecutar las migraciones
cd /var/www/api.ranktracker.tech
php artisan migrate
# Acceder a MySQL como root
mysql -u root -p
# Ingresa la contraseña que estableciste anteriormente: SNDU438jsuhs736YH
# Ejecutar las migraciones
cd /var/www/api.ranktracker.tech
php artisan migrate
# Acceder a MySQL nuevamente
mysql -u root -p
# Ingresa la contraseña root: SNDU438jsuhs736YH
# Editar archivo .env para actualizar la contraseña
cat > /var/www/api.ranktracker.tech/.env << 'EOL'
APP_NAME="Rank Tracker API"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://api.ranktracker.tech

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=rank_tracker_api
DB_USERNAME=rankuser
DB_PASSWORD=Rank$Track3r@2025!

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

DATAFORSEO_LOGIN=contacto@seobyleo.com
DATAFORSEO_PASSWORD=bee53869a8810767
EOL

# Limpiar configuración
php artisan config:clear
# Ejecutar migraciones
php artisan migrate
# Eliminar las migraciones actuales
rm -f /var/www/api.ranktracker.tech/database/migrations/2025_03_16_172152_*.php
# Crear nuevas migraciones en el orden correcto
php artisan make:migration create_plans_table --create=plans
php artisan make:migration create_licenses_table --create=licenses
php artisan make:migration create_api_usages_table --create=api_usages
# Obtener los nombres de los nuevos archivos
PLANS_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_plans_table.php | head -1)
LICENSES_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_licenses_table.php | head -1)
API_USAGES_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_api_usages_table.php | head -1)
# Mostrar los nombres
echo "Plans migration: $PLANS_MIGRATION"
echo "Licenses migration: $LICENSES_MIGRATION"
echo "API Usages migration: $API_USAGES_MIGRATION"
# Editar migración de plans
cat > $PLANS_MIGRATION << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('plans', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('daily_limit');
            $table->decimal('price', 8, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plans');
    }
};
EOL

# Editar migración de licenses
cat > $LICENSES_MIGRATION << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('licenses', function (Blueprint $table) {
            $table->id();
            $table->string('license_key')->unique();
            $table->foreignId('plan_id')->constrained();
            $table->string('domain')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('licenses');
    }
};
EOL

# Editar migración de api_usages
cat > $API_USAGES_MIGRATION << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('api_usages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('license_id')->constrained();
            $table->date('usage_date');
            $table->integer('usage_count')->default(0);
            $table->timestamps();
            $table->unique(['license_id', 'usage_date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('api_usages');
    }
};
EOL

# Limpiar la base de datos para empezar desde cero
php artisan migrate:fresh
# Si pide confirmación, responde "yes"
# Eliminar todas las migraciones personalizadas
rm -f /var/www/api.ranktracker.tech/database/migrations/*_create_plans_table.php
rm -f /var/www/api.ranktracker.tech/database/migrations/*_create_licenses_table.php
rm -f /var/www/api.ranktracker.tech/database/migrations/*_create_api_usages_table.php
# Conectarse a MySQL y eliminar la base de datos para empezar limpio
mysql -u root -p << 'EOF'
DROP DATABASE IF EXISTS rank_tracker_api;
CREATE DATABASE rank_tracker_api;
GRANT ALL PRIVILEGES ON rank_tracker_api.* TO 'rankuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Crear migración para plans
php artisan make:migration create_plans_table --create=plans
# Editar la migración de plans (copiar el nombre exacto del archivo generado)
PLANS_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_plans_table.php | head -1)
cat > $PLANS_MIGRATION << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('plans', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('daily_limit');
            $table->decimal('price', 8, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plans');
    }
};
EOL

# Ejecutar SOLO la migración de plans
php artisan migrate
# Crear migración para licenses
php artisan make:migration create_licenses_table --create=licenses
# Editar la migración de licenses
LICENSES_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_licenses_table.php | head -1)
cat > $LICENSES_MIGRATION << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('licenses', function (Blueprint $table) {
            $table->id();
            $table->string('license_key')->unique();
            $table->foreignId('plan_id')->constrained();
            $table->string('domain')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('licenses');
    }
};
EOL

# Ejecutar SOLO las migraciones restantes (que incluirá licenses)
php artisan migrate
# Crear migración para api_usages
php artisan make:migration create_api_usages_table --create=api_usages
# Editar la migración de api_usages
API_USAGES_MIGRATION=$(ls -t /var/www/api.ranktracker.tech/database/migrations/*create_api_usages_table.php | head -1)
cat > $API_USAGES_MIGRATION << 'EOL'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('api_usages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('license_id')->constrained();
            $table->date('usage_date');
            $table->integer('usage_count')->default(0);
            $table->timestamps();
            $table->unique(['license_id', 'usage_date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('api_usages');
    }
};
EOL

# Ejecutar las migraciones restantes (que incluirá api_usages)
php artisan migrate
# Crear planes predefinidos
cd /var/www/api.ranktracker.tech
php artisan tinker << 'EOF'
\App\Models\Plan::create(['name' => 'Básico', 'daily_limit' => 20, 'price' => 19.99]);
\App\Models\Plan::create(['name' => 'Pro', 'daily_limit' => 50, 'price' => 39.99]);
\App\Models\Plan::create(['name' => 'Empresarial', 'daily_limit' => 150, 'price' => 99.99]);
exit
EOF

# Crear el middleware
php artisan make:middleware VerifyApiKey
# Implementar el middleware
cat > app/Http/Middleware/VerifyApiKey.php << 'EOL'
<?php

namespace App\Http\Middleware;

use App\Models\License;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class VerifyApiKey
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next): Response
    {
        $apiKey = $request->header('X-API-Key');
        
        if (!$apiKey) {
            return response()->json([
                'success' => false,
                'error' => 'api_key_missing',
                'message' => 'API key requerida'
            ], 401);
        }
        
        $license = License::where('license_key', $apiKey)
                         ->where('is_active', true)
                         ->where(function ($query) {
                             $query->whereNull('expires_at')
                                   ->orWhere('expires_at', '>', now());
                         })
                         ->first();
        
        if (!$license) {
            return response()->json([
                'success' => false,
                'error' => 'invalid_license',
                'message' => 'Licencia inválida o expirada'
            ], 401);
        }
        
        // Añadir la licencia a la solicitud para uso posterior
        $request->license = $license;
        
        return $next($request);
    }
}
EOL

# Registrar el middleware en el kernel
sed -i "/protected \$middlewareAliases = \[/a\
        'verify.apikey' => \\App\\Http\\Middleware\\VerifyApiKey::class," /var/www/api.ranktracker.tech/app/Http/Kernel.php
# Crear directorio de servicios si no existe
mkdir -p app/Services
# Crear servicio DataForSEO
cat > app/Services/DataForSeoService.php << 'EOL'
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
EOL

# Crear directorio para controladores API
mkdir -p app/Http/Controllers/Api
# Crear e implementar controlador de Rankings
php artisan make:controller Api/RankingController
cat > app/Http/Controllers/Api/RankingController.php << 'EOL'
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ApiUsage;
use App\Services\DataForSeoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RankingController extends Controller
{
    protected $dataForSeoService;
    
    public function __construct(DataForSeoService $dataForSeoService)
    {
        $this->dataForSeoService = $dataForSeoService;
    }
    
    public function checkRanking(Request $request)
    {
        try {
            // Validación de campos
            $validated = $request->validate([
                'keyword' => 'required|string|max:255',
                'domain' => 'required|string|max:255',
                'location' => 'required|string',
                'language' => 'required|string',
            ]);
            
            // Obtener licencia (viene del middleware)
            $license = $request->license;
            $plan = $license->plan;
            
            // Verificar límite diario
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            if ($usage->usage_count >= $plan->daily_limit) {
                return response()->json([
                    'success' => false,
                    'error' => 'limit_exceeded',
                    'message' => "Has alcanzado el límite diario de {$plan->daily_limit} verificaciones",
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count
                ]);
            }
            
            // Verificar ranking con DataForSEO
            $result = $this->dataForSeoService->checkRanking(
                $validated['keyword'],
                $validated['domain'],
                $validated['location'],
                $validated['language']
            );
            
            if ($result['success']) {
                // Incrementar contador de uso
                $usage->increment('usage_count');
                
                return response()->json([
                    'success' => true,
                    'position' => $result['position'],
                    'url' => $result['url'],
                    'usage_count' => $usage->usage_count,
                    'daily_limit' => $plan->daily_limit
                ]);
            }
            
            return response()->json($result, 500);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
    
    public function getLicenseInfo(Request $request)
    {
        try {
            // Obtener licencia (viene del middleware)
            $license = $request->license;
            $plan = $license->plan;
            
            // Obtener uso actual
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            return response()->json([
                'success' => true,
                'license' => [
                    'key' => $license->license_key,
                    'plan' => $plan->name,
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count,
                    'expires_at' => $license->expires_at,
                    'is_active' => $license->is_active
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
}
EOL

# Crear e implementar controlador de Licencias
php artisan make:controller Api/LicenseController
cat > app/Http/Controllers/Api/LicenseController.php << 'EOL'
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\License;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class LicenseController extends Controller
{
    public function validateLicense(Request $request)
    {
        try {
            // Validar campos
            $validated = $request->validate([
                'license_key' => 'required|string',
            ]);
            
            // Buscar la licencia
            $license = License::where('license_key', $validated['license_key'])
                             ->where('is_active', true)
                             ->first();
            
            if (!$license) {
                return response()->json([
                    'success' => false,



EXIT
EXIT;
# Crear el directorio si no existe
mkdir -p app/Services

# Usar nano para editar el archivo
nano app/Services/DataForSeoService.php

# Crear directorio para controladores API
mkdir -p app/Http/Controllers/Api
# Crear e implementar controlador de Rankings
php artisan make:controller Api/RankingController
cat > app/Http/Controllers/Api/RankingController.php << 'EOL'
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ApiUsage;
use App\Services\DataForSeoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RankingController extends Controller
{
    protected $dataForSeoService;
    
    public function __construct(DataForSeoService $dataForSeoService)
    {
        $this->dataForSeoService = $dataForSeoService;
    }
    
    public function checkRanking(Request $request)
    {
        try {
            // Validación de campos
            $validated = $request->validate([
                'keyword' => 'required|string|max:255',
                'domain' => 'required|string|max:255',
                'location' => 'required|string',
                'language' => 'required|string',
            ]);
            
            // Obtener licencia (viene del middleware)
            $license = $request->license;
            $plan = $license->plan;
            
            // Verificar límite diario
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            if ($usage->usage_count >= $plan->daily_limit) {
                return response()->json([
                    'success' => false,
                    'error' => 'limit_exceeded',
                    'message' => "Has alcanzado el límite diario de {$plan->daily_limit} verificaciones",
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count
                ]);
            }
            
            // Verificar ranking con DataForSEO
            $result = $this->dataForSeoService->checkRanking(
                $validated['keyword'],
                $validated['domain'],
                $validated['location'],
                $validated['language']
            );
            
            if ($result['success']) {
                // Incrementar contador de uso
                $usage->increment('usage_count');
                
                return response()->json([
                    'success' => true,
                    'position' => $result['position'],
                    'url' => $result['url'],
                    'usage_count' => $usage->usage_count,
                    'daily_limit' => $plan->daily_limit
                ]);
            }
            
            return response()->json($result, 500);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
    
    public function getLicenseInfo(Request $request)
    {
        try {
            // Obtener licencia (viene del middleware)
            $license = $request->license;
            $plan = $license->plan;
            
            // Obtener uso actual
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            return response()->json([
                'success' => true,
                'license' => [
                    'key' => $license->license_key,
                    'plan' => $plan->name,
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count,
                    'expires_at' => $license->expires_at,
                    'is_active' => $license->is_active
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
}
EOL

# Crear e implementar controlador de Licencias
php artisan make:controller Api/LicenseController
cat > app/Http/Controllers/Api/LicenseController.php << 'EOL'
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\License;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class LicenseController extends Controller
{
    public function validateLicense(Request $request)
    {
        try {
            // Validar campos
            $validated = $request->validate([
                'license_key' => 'required|string',
            ]);
            
            // Buscar la licencia
            $license = License::where('license_key', $validated['license_key'])
                             ->where('is_active', true)
                             ->first();
            
            if (!$license) {
                return response()->json([
                    'success' => false,
                    'error' => 'invalid_license',
                    'message' => 'Licencia inválida o inactiva'
                ]);
            }
            
            // Verificar fecha de expiración
            if ($license->expires_at && now()->greaterThan($license->expires_at)) {
                return response()->json([
                    'success' => false,
                    'error' => 'expired_license',
                    'message' => 'La licencia ha expirado'
                ]);
            }
            
            // Asociar dominio si está vacío
            if (empty($license->domain) && $request->has('domain')) {
                $license->domain = $request->domain;
                $license->save();
            }
            
            // Verificar dominio si está establecido
            if (!empty($license->domain) && $request->has('domain') && $license->domain !== $request->domain) {
                return response()->json([
                    'success' => false,
                    'error' => 'domain_mismatch',
                    'message' => 'La licencia está asociada a otro dominio'
                ]);
            }
            
            return response()->json([
                'success' => true,
                'message' => 'Licencia válida',
                'plan' => [
                    'name' => $license->plan->name,
                    'daily_limit' => $license->plan->daily_limit
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('License Validation Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }


# Crear el directorio si no existe
mkdir -p app/Services
# Usar nano para editar el archivo
nano app/Services/DataForSeoService.php
# Asegurarnos de que el directorio existe
mkdir -p app/Http/Controllers/Api
# Crear el controlador base
php artisan make:controller Api/RankingController
# Editar con nano
nano app/Http/Controllers/Api/RankingController.php
# Crear el controlador base
php artisan make:controller Api/LicenseController
# Editar con nano
nano app/Http/Controllers/Api/LicenseController.php
# Crear el middleware
php artisan make:middleware VerifyApiKey
# Editar el archivo
nano app/Http/Middleware/VerifyApiKey.php
# Editar el Kernel
nano app/Http/Kernel.php
# Editar el archivo de rutas API
nano routes/api.php
# Crear el comando
php artisan make:command GenerateLicense
# Editar el comando
nano app/Console/Commands/GenerateLicense.php
# Configurar la tarea cron para Laravel
(crontab -l 2>/dev/null; echo "* * * * * cd /var/www/api.ranktracker.tech && php artisan schedule:run >> /dev/null 2>&1") | crontab -
# Comprobar que el DNS esté configurado
host api.ranktracker.tech
# Si el DNS está configurado, obtener el certificado
certbot --nginx -d api.ranktracker.tech
# Limpiar caché y optimizar
php artisan optimize:clear
php artisan optimize
php artisan license:generate 1
cd /var/www/api.ranktracker.tech
php artisan license:generate 1
cd /var/www/api.ranktracker.tech
php artisan license:generate 2
cd /var/www/api.ranktracker.tech
php artisan license:generate basico
cd /var/www/api.ranktracker.tech
php artisan license:generate
cd /var/www
api.ranktracker.tech
cd root@srv757691:~# cd /var/www
root@srv757691:/var/www# api.ranktracker.tech
api.ranktracker.tech: command
cd api.ranktracker.tech
ls
cat config
cat composer.json
cd app
ls
cd services
cd Services
ls
cat DataForSeoService.php
# Volver a entrar en Tinker
php artisan tinker
# Editar el modelo Plan
nano app/Models/Plan.php
# 1. Limpiar la caché de configuración y recompilar
php artisan optimize:clear
php artisan optimize
# 2. Reiniciar Nginx para asegurar que todas las configuraciones web están activas
sudo systemctl restart nginx
# 3. Reiniciar PHP-FPM para asegurar que todas las configuraciones PHP están activas
sudo systemctl restart php8.1-fpm
# 4. Verificar que todo sigue funcionando
php artisan --version
# Navegar al directorio del proyecto Laravel
cd /var/www/api.ranktracker.tech
# Verificar que el archivo artisan existe
ls -la artisan
# Si existe, ejecutar los comandos
php artisan --version
php artisan tinker
mysql -u rankuser -p rank_tracker_api -e "SELECT * FROM plans;"
php artisan tinker
// Dentro de tinker, crea los planes con los precios correctos
\App\Models\Plan::create(['name' => 'Básico', 'daily_limit' => 20, 'price' => 6.49]);
\App\Models\Plan::create(['name' => 'Pro', 'daily_limit' => 50, 'price' => 12.49]);
\App\Models\Plan::create(['name' => 'Empresarial', 'daily_limit' => 150, 'price' => 24.99]);
// Verificar que se han creado correctamente
\App\Models\Plan::all();
php artisan tinker
php artisan license:generate 1
# Reemplaza TU_LICENCIA_KEY con la clave generada en el paso anterior
curl -X POST http://localhost/api/validate-license   -H "Content-Type: application/json"   -d '{"license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST http://69.62.107.28/api/validate-license   -H "Content-Type: application/json"   -d '{"license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST http://127.0.0.1/api/validate-license   -H "Content-Type: application/json"   -d '{"license_key":"A9C50725-40FF4985-9DCFDE9F"}'
php artisan route:list
# Usando la URL completa con el dominio
curl -X POST https://api.ranktracker.tech/api/validate-license   -H "Content-Type: application/json"   -d '{"license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
# Ver los últimos errores del log de Laravel
tail -n 100 storage/logs/laravel.log
# Verificar si el archivo de configuración tiene las credenciales
cat config/services.php
cat << 'EOF' > /var/www/api.ranktracker.tech/config/services.php
<?php
return [
    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */
    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),
        'scheme' => 'https',
    ],
    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],
    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],
    'dataforseo' => [
        'login' => env('DATAFORSEO_LOGIN', 'contacto@seobyleo.com'),
        'password' => env('DATAFORSEO_PASSWORD', 'bee53869a8810767'),
        'api_url' => env('DATAFORSEO_URL', 'https://api.dataforseo.com/'),
    ],
];
EOF

grep -i DATAFORSEO /var/www/api.ranktracker.tech/.env || echo -e "\n# DataForSEO API credentials\nDATAFORSEO_LOGIN=contacto@seobyleo.com\nDATAFORSEO_PASSWORD=bee53869a8810767\nDATAFORSEO_URL=https://api.dataforseo.com/" >> /var/www/api.ranktracker.tech/.env
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
cd /var/www/api.ranktracker.tech
tail -n 100 storage/logs/laravel.log
# Comprobar si el archivo existe y ver su contenido
ls -la /var/www/api.ranktracker.tech/config/services.php
cat /var/www/api.ranktracker.tech/config/services.php
# Comprobar si existe el directorio de controladores de API
ls -la /var/www/api.ranktracker.tech/app/Http/Controllers/Api/
# Comprobar si existe el controlador específico
ls -la /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php
# Comprobar si existe el directorio de servicios
ls -la /var/www/api.ranktracker.tech/app/Services/
# Comprobar si existe el servicio de DataForSEO
ls -la /var/www/api.ranktracker.tech/app/Services/DataForSEOService.php
# Examinar el contenido del archivo de servicio actual para verificar la definición de la clase
cat /var/www/api.ranktracker.tech/app/Services/DataForSeoService.php
# Examinar el controlador para ver cómo está importando el servicio
cat /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php
cat << 'EOF' > /var/www/api.ranktracker.tech/app/Services/DataForSeoService.php
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
EOF

/var/www/api.ranktracker.tech/app/Services/DataForSeoService.php
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
curl -X POST http://127.0.0.1/api/validate-license   -H "Content-Type: application/json"   -d '{"license_key":"A9C50725-40FF4985-9DCFDE9F"}'
# Usando la URL completa con el dominio
curl -X POST https://api.ranktracker.tech/api/validate-license   -H "Content-Type: application/json"   -d '{"license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en","license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en","license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en","license_key":"A9C50725-40FF4985-9DCFDE9F"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
php -r '
$login = "contacto@seobyleo.com";
$password = "bee53869a8810767";
$url = "https://api.dataforseo.com/v3/merchant/google/locations";
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
$result = curl_exec($ch);
$info = curl_getinfo($ch);
curl_close($ch);
echo "HTTP Code: " . $info["http_code"] . "\n";
if ($info["http_code"] == 200) {
    $response = json_decode($result, true);
    echo "Status code: " . $response["status_code"] . "\n";
    echo "Status message: " . $response["status_message"] . "\n";
} else {
    echo "Error: " . $result . "\n";
}
'
# Ver el controlador actual
cat /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php
# Si necesitas modificarlo, hazlo con cuidado para adaptarlo a tu estructura
cat << 'EOF' > /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ApiUsage;
use App\Models\License;
use App\Services\DataForSeoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RankingController extends Controller
{
    protected $dataForSeoService;
    
    public function __construct(DataForSeoService $dataForSeoService)
    {
        $this->dataForSeoService = $dataForSeoService;
    }
    
    public function checkRanking(Request $request)
    {
        try {
            // Registrar la solicitud para depuración
            Log::info('RankingController: Solicitud recibida', [
                'data' => $request->all(),
                'has_license' => isset($request->license)
            ]);
            
            // Validación de campos
            $validated = $request->validate([
                'keyword' => 'required|string|max:255',
                'domain' => 'required|string|max:255',
                'location' => 'required|string',
                'language' => 'required|string',
                'license_key' => 'required|string',
            ]);
            
            // Buscar la licencia por la clave
            $license = License::where('license_key', $validated['license_key'])
                             ->where('is_active', true)
                             ->first();
            
            if (!$license) {
                return response()->json([
                    'success' => false,
                    'error' => 'invalid_license',
                    'message' => 'Licencia inválida o no activa'
                ], 401);
            }
            
            $plan = $license->plan;
            
            // Verificar límite diario
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            if ($usage->usage_count >= $plan->daily_limit) {
                return response()->json([
                    'success' => false,
                    'error' => 'limit_exceeded',
                    'message' => "Has alcanzado el límite diario de {$plan->daily_limit} verificaciones",
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count
                ]);
            }
            
            // Verificar ranking con DataForSEO
            $result = $this->dataForSeoService->checkRanking(
                $validated['keyword'],
                $validated['domain'],
                $validated['location'],
                $validated['language']
            );
            
            if ($result['success']) {
                // Incrementar contador de uso
                $usage->increment('usage_count');
                
                return response()->json([
                    'success' => true,
                    'position' => $result['position'],
                    'url' => $result['url'],
                    'usage_count' => $usage->usage_count,
                    'daily_limit' => $plan->daily_limit
                ]);
            }
            
            return response()->json($result, 500);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage(), [
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
    
    public function getLicenseInfo(Request $request)
    {
        try {
            // Validación de campos
            $validated = $request->validate([
                'license_key' => 'required|string',
            ]);
            
            // Buscar la licencia por la clave
            $license = License::where('license_key', $validated['license_key'])
                             ->where('is_active', true)
                             ->first();
            
            if (!$license) {
                return response()->json([
                    'success' => false,
                    'error' => 'invalid_license',
                    'message' => 'Licencia inválida o no activa'
                ], 401);
            }
            
            $plan = $license->plan;
            
            // Obtener uso actual
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            return response()->json([
                'success' => true,
                'license' => [
                    'key' => $license->license_key,
                    'plan' => $plan->name,
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count,
                    'expires_at' => $license->expires_at,
                    'is_active' => $license->is_active
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
}
EOF

cat << 'EOF' > /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php

exit



cat << 'EOF' > /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php

exit





EXIT
;
EOF

cat << 'EOF' > /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ApiUsage;
use App\Models\License;
use App\Services\DataForSeoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RankingController extends Controller
{
    protected $dataForSeoService;
    
    public function __construct(DataForSeoService $dataForSeoService)
    {
        $this->dataForSeoService = $dataForSeoService;
    }
    
    public function checkRanking(Request $request)
    {
        try {
            // Registrar la solicitud para depuración
            Log::info('RankingController: Solicitud recibida', [
                'data' => $request->all(),
                'has_license' => isset($request->license)
            ]);
            
            // Validación de campos
            $validated = $request->validate([
                'keyword' => 'required|string|max:255',
                'domain' => 'required|string|max:255',
                'location' => 'required|string',
                'language' => 'required|string',
                'license_key' => 'required|string',
            ]);
            
            // Buscar la licencia por la clave
            $license = License::where('license_key', $validated['license_key'])
                             ->where('is_active', true)
                             ->first();
            
            if (!$license) {
                return response()->json([
                    'success' => false,
                    'error' => 'invalid_license',
                    'message' => 'Licencia inválida o no activa'
                ], 401);
            }
            
            $plan = $license->plan;
            
            // Verificar límite diario
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            if ($usage->usage_count >= $plan->daily_limit) {
                return response()->json([
                    'success' => false,
                    'error' => 'limit_exceeded',
                    'message' => "Has alcanzado el límite diario de {$plan->daily_limit} verificaciones",
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count
                ]);
            }
            
            // Verificar ranking con DataForSEO
            $result = $this->dataForSeoService->checkRanking(
                $validated['keyword'],
                $validated['domain'],
                $validated['location'],
                $validated['language']
            );
            
            if ($result['success']) {
                // Incrementar contador de uso
                $usage->increment('usage_count');
                
                return response()->json([
                    'success' => true,
                    'position' => $result['position'],
                    'url' => $result['url'],
                    'usage_count' => $usage->usage_count,
                    'daily_limit' => $plan->daily_limit
                ]);
            }
            
            return response()->json($result, 500);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage(), [
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
    
    public function getLicenseInfo(Request $request)
    {
        try {
            // Validación de campos
            $validated = $request->validate([
                'license_key' => 'required|string',
            ]);
            
            // Buscar la licencia por la clave
            $license = License::where('license_key', $validated['license_key'])
                             ->where('is_active', true)
                             ->first();
            
            if (!$license) {
                return response()->json([
                    'success' => false,
                    'error' => 'invalid_license',
                    'message' => 'Licencia inválida o no activa'
                ], 401);
            }
            
            $plan = $license->plan;
            
            // Obtener uso actual
            $today = now()->format('Y-m-d');
            $usage = ApiUsage::firstOrCreate(
                ['license_id' => $license->id, 'usage_date' => $today],
                ['usage_count' => 0]
            );
            
            return response()->json([
                'success' => true,
                'license' => [
                    'key' => $license->license_key,
                    'plan' => $plan->name,
                    'daily_limit' => $plan->daily_limit,
                    'usage_count' => $usage->usage_count,
                    'expires_at' => $license->expires_at,
                    'is_active' => $license->is_active
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('API Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => 'server_error',
                'message' => 'Error en el servidor: ' . $e->getMessage()
            ], 500);
        }
    }
}
EOF

# Abrir el archivo con nano
nano /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php
cat /var/www/api.ranktracker.tech/app/Services/DataForSeoService.php
cat /var/www/api.ranktracker.tech/config/services.php
cat /var/www/api.ranktracker.tech/routes/api.php
cat /var/www/api.ranktracker.tech/app/Http/Kernel.php | grep verify.apikey
cat /var/www/api.ranktracker.tech/app/Http/Middleware/VerifyApiKey.php
# Editar el RankingController
nano /var/www/api.ranktracker.tech/app/Http/Controllers/Api/RankingController.php
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"en"}'
tail -n 100 /var/www/api.ranktracker.tech/storage/logs/laravel.log
# Buscar la ubicación de la migración para cada modelo
php artisan make:model License --migration
php artisan make:model ApiUsage --migration
php artisan make:model Plan --migration
php artisan migrate:status
# Ubicación típica de los modelos
cat app/Models/License.php
cat app/Models/ApiUsage.php
cat app/Models/Plan.php
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "X-API-Key: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2840","language":"es"}'
tail -n 50 /var/log/nginx/error.log
tail -n 50 /var/log/php/error.log
curl -X POST https://api.ranktracker.tech/api/check-ranking   -H "Content-Type: application/json"   -H "license_keyy: A9C50725-40FF4985-9DCFDE9F"   -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"22724,"language":"es"}'
tail -n 50 /var/log/php/error.log
curl -X POST https://api.ranktracker.tech/api/check-ranking   
-H "Content-Type: application/json"   
-H "X-API-Key: AA9C50725-40FF4985-9DCFDE9F"   
-d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2724","language":"es"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking   
-H "Content-Type: application/json"   
-H "X-API-Key: AA9C50725-40FF4985-9DCFDE9F"   
-d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2724","language":"es"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking -H "Content-Type: application/json" -H "X-API-Key: AA9C50725-40FF4985-9DCFDE9F" -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2724","language":"es"}'
# Generar una licencia para el plan Básico (ID 1)
php artisan license:generate 1
curl -X POST https://api.ranktracker.tech/api/check-ranking -H "Content-Type: application/json" -H "X-API-Key: CAABE8F1-4C4C88BE-1AEE7F63" -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2724","language":"es"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking -H "Content-Type: application/json" -H "X-API-KABE8F1-4C4C88BE-1AEE7F63" -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2724","language":"es"}'
curl -X POST https://api.ranktracker.tech/api/check-ranking -H "Content-Type: application/json" -H "X-API-Key: CAABE8F1-4C4C88BE-1AEE7F63" -d '{"keyword":"rank tracker wordpress","domain":"ranktracker.tech","location":"2724","language":"es"}'
cd /var/www/api.ranktracker.tech
tail -n 50 storage/logs/laravel.log
php artisan route:list
php artisan tinker
>>> \App\Models\License::where('license_key', 'CAABE8F1-4C4C88BE-1AEE7F63')->first()
php artisan migrate:status
