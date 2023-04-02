import email
import imaplib
import re
usr_email_sender = 'bullmarkettesting@gmail.com'
usr_email_password = 'ywidxfukfppviggj'
# using the email library to read the last email recieved
def get_email(email_sender, email_password):
    mail = imaplib.IMAP4_SSL('imap.gmail.com')
    mail.login(email_sender, email_password)
    mail.list()
    mail.select('inbox')
    result, data = mail.uid('search', None, "ALL")
    inbox_item_list = data[0].split()
    latest_email_uid = inbox_item_list[-1]
    result, email_data = mail.uid('fetch', latest_email_uid, '(RFC822)')
    raw_email = email_data[0][1].decode('utf-8')
    email_message = email.message_from_string(raw_email)
    for part in email_message.walk():
        if part.get_content_type() == "text/plain":
            body = part.get_payload(decode=True)
            mail.logout()
            return str(body)
    mail.logout()
def email_parser(email_body):
    patron = r':(\d{6})'  # patrón para buscar un número de 6 dígitos que tenga ":" antes
    resultado = re.search(patron, email_body)
    return resultado
def obtain_numeric_email(email_sender, email_password):
    email_body = get_email(email_sender, email_password)
    number = email_parser(email_body)
    return str(number.group(1))