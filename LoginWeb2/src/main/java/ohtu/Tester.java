package ohtu;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

public class Tester {

    public static void main(String[] args) {
        WebDriver driver = new HtmlUnitDriver();

        driver.get("http://localhost:8080");
        System.out.println(driver.getPageSource());
        WebElement element = driver.findElement(By.linkText("login"));
        element.click();

        System.out.println("==");
        //case 1: right username, wrong password     
        element = driver.findElement(By.name("username"));
        element.sendKeys("pekka");
        element = driver.findElement(By.name("password"));
        element.sendKeys("akkep1");
        element = driver.findElement(By.name("login"));
        element.submit();
        
        System.out.println(driver.getPageSource());
        
        //case 2: wrong username
        element = driver.findElement(By.name("username"));
        element.sendKeys("Luke");
        element = driver.findElement(By.name("password"));
        element.sendKeys("akkep1");
        element = driver.findElement(By.name("login"));
        element.submit();
        
        System.out.println(driver.getPageSource());
        
        //case 3: creating new user
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));
        element.click();
        element = driver.findElement(By.name("username"));
        element.sendKeys("kalle1");
        element = driver.findElement(By.name("password"));
        element.sendKeys("1234567k");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("1234567k");
        element = driver.findElement(By.name("add"));
        element.submit();
        
        System.out.println("==");
        System.out.println(driver.getPageSource());
        
        //case 4: creating new user and logging in with it
         driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));
        element.click();
        element = driver.findElement(By.name("username"));
        element.sendKeys("kalle6");
        element = driver.findElement(By.name("password"));
        element.sendKeys("1234567a");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("1234567a");
        element = driver.findElement(By.name("add"));
        element.submit();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("login"));
        element.click();
        element = driver.findElement(By.name("username"));
        element.sendKeys("kalle6");
        element = driver.findElement(By.name("password"));
        element.sendKeys("1234567a");
        element = driver.findElement(By.name("login"));
        element.submit();
        
        System.out.println(driver.getPageSource());

    }
}
