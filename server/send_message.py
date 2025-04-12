import firebase_admin
from firebase_admin import credentials, messaging

cred = credentials.Certificate("serviceKey.json")
firebase_admin.initialize_app(cred)

def send_to_topic(topic, title, body, data=None):
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body
        ),
        data=data,
        topic=topic
    )
    try:
        response = messaging.send(message)
        print('Successfully sent message:', response)
    except Exception as e:
        print('Error sending message:', e)

if __name__ == "__main__":
    send_to_topic(
    topic="news_updates",
    title="New news available!",
    body="Check out the latest news updates in the app.",
    )

