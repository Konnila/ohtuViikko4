import ohtu.*
import ohtu.authentication.*
import org.openqa.selenium.*
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

description """A new user account can be created 
              if a proper unused username 
              and a proper password are given"""

scenario "creation succesfull with correct username and password", {
    given 'command new user is selected', {
       driver = new HtmlUnitDriver();
       driver.get("http://localhost:8080");
       element = driver.findElement(By.linkText("register new user"));       
       element.click(); 
    }
 
    when 'a valid username and password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("pekkapekka");
        element = driver.findElement(By.name("password"));
        element.sendKeys("akkeppekka1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("akkeppekka1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }

    then 'new user is registered to system', {
        driver.getPageSource().contains("Welcome to Ohtu App").shouldBe true
    }
}

scenario "can login with succesfully generated account", {
    given 'command new user is selected', {
       driver = new HtmlUnitDriver();
       driver.get("http://localhost:8080");
       element = driver.findElement(By.linkText("register new user"));       
       element.click();
    }
 
    when 'a valid username and password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("pekkaBekka");
        element = driver.findElement(By.name("password"));
        element.sendKeys("bakkeppekka1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("bakkeppekka1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }

    then  'new credentials allow logging in to system', {
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("login"));       
        element.click();

        element = driver.findElement(By.name("username"));
        element.sendKeys("pekkaBekka");
        element = driver.findElement(By.name("password"));
        element.sendKeys("bakkeppekka1");
        element = driver.findElement(By.name("login"));
        element.submit();

        driver.getPageSource().contains("Welcome to Ohtu Application!").shouldBe true
    }
}

scenario "creation fails with correct username and too short password", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    
    when 'a valid username and too short password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("jalmarimari");
        element = driver.findElement(By.name("password"));
        element.sendKeys("mari1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("mari1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }

    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and").shouldBe true
    }
}

scenario "creation fails with correct username and pasword consisting of letters", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    when 'a valid username and password consisting of letters are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("jalmarimari");
        element = driver.findElement(By.name("password"));
        element.sendKeys("marimari");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("marimari");
        element = driver.findElement(By.name("add"));
        element.submit();
    }
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and").shouldBe true
    }
}

scenario "creation fails with too short username and valid pasword", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }

    when 'a too sort username and valid password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("ari");
        element = driver.findElement(By.name("password"));
        element.sendKeys("marimari1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("marimari1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }

    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and").shouldBe true
    }
}

scenario "creation fails with already taken username and valid pasword", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }

    when 'a already taken username and valid password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("pekkaBekka");
        element = driver.findElement(By.name("password"));
        element.sendKeys("marimari1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("marimari1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }

    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and").shouldBe true
    }
}

scenario "can not login with account that is not succesfully created", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }

    when 'a invalid username/password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("ari");
        element = driver.findElement(By.name("password"));
        element.sendKeys("ba1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("ba1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }
    
    then  'new credentials do not allow logging in to system', {
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("login"));       
        element.click();
        
        element = driver.findElement(By.name("username"));
        element.sendKeys("ari");
        element = driver.findElement(By.name("password"));
        element.sendKeys("ba1");
        element = driver.findElement(By.name("login"));
        element.submit();

        driver.getPageSource().contains("Give your credentials").shouldBe true
    }
}