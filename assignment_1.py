from selenium import webdriver
import time


#browser = webdriver.Firefox(executable_path=r"C:\Users\Udyant\Documents\Huawei_assignment_udyant\geckodriver.exe")
driver = webdriver.Chrome(executable_path=r"C:\Users\Udyant\Documents\Huawei_assignment_udyant\chromedriver.exe")  #please specify path of chromedriver here
driver.get('https://www.amazon.com/')
#assert "amazon" in driver.page_source
searchelem = driver.find_element_by_id("twotabsearchtextbox")
searchelem.clear()
searchelem.send_keys("Nikon")
#searchelem.send_keys(Keys.RETURN)
searchelem.submit()
el = driver.find_elements_by_xpath("//*[contains(text(), 'Nikon')]")
count = len(el)
try:
    assert count != 0, "Multiple results found"
    print(count)
except AssertionError as e:
    print("No results found")
sortelem = driver.find_element_by_xpath("//span[contains(@aria-label,'Sort by:')]")
sortelem.click()
time.sleep(3)
selecteoption = driver.find_element_by_xpath("//a[contains(text(), 'Price: High to Low')]")
selecteoption.click()
time.sleep(3)
#selecteditem = driver.find_element_by_xpath("//div[contains(@data-index,'1')]//a").get_attribute("href")
#print(selecteditem)
selecteditem = driver.find_element_by_xpath("//div[contains(@data-index,'1')]//a")
selecteditem.click()
time.sleep(3)
txt = "Nikon D3X"
try:
    assert(txt in driver.page_source)
except AssertionError as e:
    print(txt+" not found in the page")
#assert driver.page_source.find("Nikon D3X")
driver.close()
quit()