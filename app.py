from flask import Flask, render_template, request
import subprocess
import threading
import time

app = Flask(__name__)


def destroy_resources():
    time.sleep(120)  # Wait for 2 minutes
    subprocess.run(['terraform', 'destroy', '-auto-approve'])

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/create_resources', methods=['POST'])
def create_resources():
    
    # Execute Terraform script
    subprocess.run(['terraform', 'apply', '-auto-approve'])
    # Start thread to destroy resources after 2 minutes
    threading.Thread(target=destroy_resources).start()
    return 'Resources creation initiated!'

if __name__ == '__main__':
    app.run(debug=True)
