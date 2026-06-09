import requests
import sys
import os
from dotenv import load_dotenv
load_dotenv()
API_KEY = os.getenv("API_KEY")

def get_weather(query,language="en"):
    url="https://api.openweathermap.org/data/2.5/weather"
    params={
        "q":query,
        "lang":language,
        "appid":API_KEY,
        'units': 'metric',
    }
    try:
        response=requests.get(url,params=params,timeout=5)
        response.raise_for_status()
        data=response.json()
        if data["cod"] != 200:
            print(f"Ошибка API {data.get('message',"Неизвестная ошибка")}")
            return None
        return data
    except requests.exceptions.RequestException as e:
        print(f"Ошибка http {e}")
        return None
    
def main():
    if len(sys.argv)>1:
        query= " ".join(sys.argv[1:])
    else:
        query=input("введите город:").strip()
        if not query:
            query="Moscow"
    
    articles=get_weather(query, language="ru")
    
    if not articles:
        print("произошла ошибка")
        return
    
    city=articles.get('name')
    temp = articles.get('main').get('temp')
    description=articles.get('weather')[0].get('description')
    humidity=articles.get('main').get('humidity')
    wind=articles.get('wind').get('speed')

    print(f"город. {city}")
    print(f"   температура: {temp}С")
    print(f"   погода: {description[:120]}")
    print(f"   влажность: {humidity}%")
    print(f"   ветер: {wind}м/с")

main()
