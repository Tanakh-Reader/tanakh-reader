import firebase_admin
from firebase_admin import credentials, db

f = 'macula/tanakh-reader-firebase-adminsdk-gati8-1a91f69256.json'
cred = credentials.Certificate(f)
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://tanakh-reader-default-rtdb.firebaseio.com/'
})

ref = db.reference(path='/')

data = ref.get()

print(data)