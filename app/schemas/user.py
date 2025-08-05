from pydantic import BaseModel

class UserCreate(BaseModel):
    phone: str
    name: str
    password: str

class UserLogin(BaseModel):
    phone: str
    password: str

class UserOut(BaseModel):
    id: int
    phone: str
    name: str
    role: str

    class Config:
        orm_mode = True
