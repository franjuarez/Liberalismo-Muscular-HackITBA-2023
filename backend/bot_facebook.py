from logging import warn
from selenium import webdriver
from time import sleep
from random import randint
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys
from get_email import obtain_numeric_email
import string
import random

def generate_password(length=12):
    """Generate a random password with the given length."""
    # Define the characters that can be used in the password
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for _ in range(length))
    return password
def facebook_scrap():
    xpath_enter_mail_account = '//*[@id="identify_email"]'
    xpath_confirm_mail_check = '//*[@id="initiate_interstitial"]/div[3]/div/div[1]/button'
    xpath_sent_mail = '/html/body/div[2]/div/div/div[2]/main/div/div/div/div[2]/div[2]/div[2]/div/div/div/div/div[1]'
    xpath_next_buttom = '/html/body/div[1]/div[1]/div[1]/div/div[2]/div/div/form/div/div[3]/div/div[1]/button'
    xpath_input_code = '//*[@id="recovery_code_entry"]'
    xpath_after_input_code = '/html/body/div[1]/div[1]/div[1]/div/div[2]/form/div/div[3]/div/div[1]/button'
    xpath_new_pass_input_box = '/html/body/div[1]/div[1]/div[1]/div/div[2]/form/div/div[2]/div[2]/div[1]/div/input'
    xpath_final_buttom = '/html/body/div[1]/div[1]/div[1]/div/div[2]/form/div/div[3]/div/div[1]/button[2]'
    mail_account = 'bullmarkettesting@gmail.com'
    password = 'testings124'
    intern_password = 'ywidxfukfppviggj'
    service = ChromeService(executable_path=ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service)
    driver.get("https://www.facebook.com/login/identify/?ctx=recover&ars=facebook_login&from_login_screen=0")
    sleep(randint(4,5))
    driver.find_element("xpath", xpath_enter_mail_account).send_keys(mail_account) #escribe el mail
#WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_enter_mail_account))).click() #escribe el mail
#WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_enter_mail_account))).send_keys(mail_account) #escribe el mail
    sleep(randint(1,5))
#WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_forgot_pass))).click() #toca el boton de forgot
    driver.find_element("xpath", xpath_next_buttom).click() #continuar despues de ingresar el mail
    sleep(randint(1,5))
    WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_confirm_mail_check))).click()
    sleep(randint(1,5))
    verification_nmb_as_str = obtain_numeric_email(mail_account, intern_password)
    WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_input_code))).click()
    sleep(randint(1,5))
    WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_input_code))).send_keys(verification_nmb_as_str)
    sleep(randint(1,5))
    WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_after_input_code))).click()
    sleep(randint(0,5))
    random_password = generate_password()
    WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_new_pass_input_box))).send_keys(random_password)
    sleep(randint(0,5))
    WebDriverWait(driver, 11).until(EC.element_to_be_clickable((By.XPATH, xpath_final_buttom))).click()
    print('terminado :D')
    print(random_password)
    return random_password
facebook_scrap()