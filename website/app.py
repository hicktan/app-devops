from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

# Não precisamos mais do app.run(), o Gunicorn vai cuidar disso.