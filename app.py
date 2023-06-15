from flask import Flask
import datetime

app = Flask(__name__)

@app.route('/')
def countdown():
    now = datetime.datetime.now()
    target = datetime.datetime(2023, 6, 16, 17, 0, 0) 
    remaining_time = target - now
    return f"Countdown: {remaining_time}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1234)
