import subprocess
import time
import os

def test_main_executes():
    """ Testa se a aplicação pode ser iniciada sem erro """
    env = os.environ.copy()
    env["PYTHONPATH"] = "/app/app"  # Define o diretório do módulo `app`
    
    process = subprocess.Popen(
        ["python", "-m", "app.main"], env=env
    )
    time.sleep(2)  # Espera para garantir que a API iniciou
    process.terminate()
    process.wait()
    
    assert process.returncode in [0, -15]  # Aceita -15 como código válido (SIGTERM)
