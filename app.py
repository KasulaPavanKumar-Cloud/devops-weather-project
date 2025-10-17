from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

@app.route("/")
def home():
    return "Welcome to the Weather App!"

@app.route("/weather")
def weather():
    city = request.args.get("city", "London")
    # Using free Open-Meteo API
    url = f"https://api.open-meteo.com/v1/forecast?latitude=51.5074&longitude=-0.1278&current_weather=true"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        temperature = data['current_weather']['temperature']
        return jsonify({"city": city, "temperature": f"{temperature}°C"})
    else:
        return jsonify({"error": "Unable to fetch weather"}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
