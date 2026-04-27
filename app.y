from flask import Flask, render_template, request, redirect
import json
import os

app = Flask(__name__)
DATA_FILE = 'data/events.json'

def load_events():
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE, 'r') as f:
        return json.load(f)

def save_events(events):
    with open(DATA_FILE, 'w') as f:
        json.dump(events, f, indent=4)

@app.route('/')
def index():
    events = load_events()
    return render_template('index.html', events=events)

@app.route('/add', methods=['POST'])
def add_event():
    events = load_events()
    new_event = {
        "name": request.form['name'],
        "date": request.form['date']
    }
    events.append(new_event)
    save_events(events)
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)
