#!/bin/bash

echo "======================================== MAKEMIGRATIONS APPS ========================================"

# Configurando la variable de entorno para evitar interacción durante las migraciones
export DJANGO_DB_MIGRATE_NO_INPUT=True

# Generar migraciones y aplicarlas
python3 Viavital/manage.py makemigrations --empty post
python3 Viavital/manage.py migrate

echo "======================================== MIGRATIONS APPS ========================================"

# Aplicar migraciones generales
python3 Viavital/manage.py migrate

echo "======================================== GENERAL MIGRATIONS ========================================"

# Iniciar el servidor
python3 Viavital/manage.py runserver 0.0.0.0:8001

echo "=================================================================="
echo "--------------------------COMPLETE--------------------------------"
echo "----- .: Django docker is fully configured successfully :. -------"
echo "=================================================================="

exec "$@"