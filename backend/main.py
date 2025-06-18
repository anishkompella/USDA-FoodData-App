
import os
from fastapi import Depends, FastAPI, HTTPException
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import requests




load_dotenv()
app = FastAPI()


app.add_middleware(
  CORSMiddleware,
  allow_origins=["*"],          
  allow_credentials=True,
  allow_methods=["*"],
  allow_headers=["*"],
)


FDC_BASE_URL= "https://api.nal.usda.gov/fdc/v1"

def get_fdc_session():
    session = requests.Session()
    session.params = {"API_KEY": os.getenv("API_KEY")}
    return session 

def get_food_by_id(fdc_id: int, session: requests.Session):
    url = f"{FDC_BASE_URL}/food/{fdc_id}"
    request = session.get(url)
    request.raise_for_status()
    return request.json()

@app.get("/food/{fdc_id}")
def get_food_details(fdc_id:int, session=Depends(get_fdc_session)):
    try:
        return get_food_by_id(fdc_id, session)
    except Exception as e:
            raise HTTPException(status_code=502, detail=str(e))

def get_food_by_search( query: str, pageSize: int, session: requests.Session):
    url = f"{FDC_BASE_URL}/foods/search"
    request = session.get(url)
    params = {
        "query": query,
        "pageSize": pageSize,
    }
    request = session.get(url, params=params)
    request.raise_for_status()
    return request.json()

@app.get("/foods/search")
def get_food(query:str, pageSize:int = 20, session=Depends(get_fdc_session)):
    try:
        return get_food_by_search(query, pageSize, session)
    except Exception as e:
        raise HTTPException(status_code=502, detail=str(e))
