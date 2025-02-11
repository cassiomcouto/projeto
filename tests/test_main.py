import subprocess  # Biblioteca para executar subprocessos
import time  # Biblioteca para manipulação de tempo
import os  # Biblioteca para interação com o sistema operacional

def test_main_executes():
    """ 
    Testa se a aplicação pode ser iniciada sem erro.
    Executa a aplicação e verifica se ela inicia corretamente.
    """
    env = os.environ.copy()  # Copia as variáveis de ambiente atuais
    env["PYTHONPATH"] = "/app/app"  # Define o diretório do módulo `app`
    
    # Inicia a aplicação como um subprocesso
    process = subprocess.Popen(
        ["python", "-m", "app.main"], env=env
    )
    
    time.sleep(2)  # Aguarda 2 segundos para garantir que a API iniciou
    
    # Finaliza o processo da aplicação
    process.terminate()
    process.wait()  # Aguarda o término do processo
    
    # Verifica se o código de saída é 0 (sucesso) ou -15 (SIGTERM esperado)
    assert process.returncode in [0, -15]
