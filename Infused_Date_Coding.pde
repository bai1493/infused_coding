import controlP5.*;
import java.util.*;
import java.util.Calendar;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import de.looksgood.ani.*;

ControlP5 cp5;

PImage logo;
PFont font;

ScrollableList b;

//date variables
DateFormat newFormat = new SimpleDateFormat("hh:mm aa 'on' EE, MMM d"); // help from https://www.w3schools.com/java/java_date.asp
Date today = new Date();
String currentDate = newFormat.format(today);
String twelve = addToDate(0, 12);
String twentyFour = addToDate(0, 24);
String fortyEight = addToDate(0, 48);
String five = addToDate(5, 0);
String seven = addToDate(7, 0);
String fourteen = addToDate(14, 0);
String thirty = addToDate(30, 0);
//end date variables

//animation variables
float speed = 1000;
float value = 0.0;
//int MAX = 255;
float fadeIn = -100;
float fadeOut = 255;

int startTime;

final int fr = 250;
//end animation

//colour variables
color teal = color(195, 240, 241);
color gray = color(111, 110, 110);
color ltgray = color(242, 242, 242);
color transparent = color(242, 242, 242, 127);
//end colour variables

//screen booleans
boolean home = true;
boolean itemDate = false;
//end screen booleans

//selected item from bevComponents[]
String selected = null;
//end selected item

//variable for dates
String dates;
//end date variable    

//beverage components string    
String[] bevComponents = {
  "black tea concentrate", //0
  "caramel sauce topping", //1
  "chocolate sauce", //2
  "coffee beans", //3
  "flavoured syrups", //4
  "ground tea powder", //5
  "iced coffee", //6
  "iced tea", //7
  "infused cool bases", //8
  "infused cool dried fruit", //9
  "lemonade", //10
  "non-dairy milk"};          //11
//end beverage components

void setup() {
  size(375, 710);
  cp5 = new ControlP5(this);
  font = createFont("pompiere.regular.ttf", 30);
  startTime = millis();
  frameRate(fr);



  //list items
  List l = Arrays.asList(bevComponents);
  b = cp5.addScrollableList("ingredients"); //help from http://www.sojamo.de/libraries/controlP5/reference/controlP5/ScrollableList.html
  b.setPosition(width/8, 150);
  b.setSize(100, 300);
  b.setBarHeight(80);
  b.setSize(300, 500);
  b.setItemHeight(70);
  b.addItems(l);
  b.setColorBackground(teal);
  b.setColorActive(teal);
  b.setColorForeground(ltgray);
  b.setColorLabel(0);
  b.setColorValueLabel(gray);
  b.setType(ScrollableList.LIST);
  b.getCaptionLabel().setFont(font);
  b.getValueLabel().setFont(font);
  b.getCaptionLabel().toUpperCase(false);
  b.getValueLabel().toUpperCase(false);      
  //end list items

  // background(#FFFFFF);
  logo = loadImage("Condensed_Transparent.png");
}

void draw() {
  background(255);
  image(logo, 15, 15);
  smooth();
  textFont(font);
  textAlign(CENTER);
  fill(gray);
  textSize(25);
  text(currentDate, width/2, height/2 - 225);
  home = true;

  //println(height/2 - 225, height/2 - 50, height/2 + 50);

  //home is default - shows list of beverage components
  if (home) {

    b.show();
  } else {
    b.hide(); //hide if home is not true
  };
  //end home


  //itemDate screen shows info for the corresponding item selected  
  if (itemDate) { //shows items info when item is selected
    b.hide(); //hides list

    //back button
    textSize(30);
    text("x", 50, 250);
    //end back button

    //item info text
    fill(gray);
    textSize(30);
    textFont(font);
    textAlign(CENTER);
    //end item info text

    //12 hour items
    if (selected == bevComponents[6] || selected == bevComponents[7]) {
      fadesIn();
      dates = "12 hour";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + twelve, width/2, height/2 + 50);
    };
    //end 12 hour items

    //24 hour items
    if (selected == bevComponents[0] || selected == bevComponents[2]) {
      fadesIn();
      dates = "24 hour";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + twentyFour, width/2, height/2 + 50);
    };
    //end 24 hour items

    //48 hour items
    if (selected == bevComponents[10]) {
      fadesIn();
      dates = "48 hour";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + fortyEight, width/2, height/2 + 50);
    };
    //end 48 hour items

    //5 day items
    if (selected == bevComponents[8] || selected == bevComponents[9]) {
      fadesIn();
      dates = "5 day";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + five, width/2, height/2 + 50);
    };
    //end 5 day items

    //7 day items
    if (selected == bevComponents[3] || selected == bevComponents[5] || selected == bevComponents[11]) {
      fadesIn();
      dates = "7 day";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + seven, width/2, height/2 + 50);
    };
    //end 7 day items

    //14 day items
    if (selected == bevComponents[1]) {
      fadesIn();
      dates = "14 day";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + fourteen, width/2, height/2 + 50);
    };
    //end 14 day items

    //30 day items
    if (selected == bevComponents[4]) {
      fadesIn();
      dates = "30 day";
      textSize(35);
      text(dates + " shelf life", width/2, height/2 - 50);
      text("date " + selected + " for: " + '\n' + thirty, width/2, height/2 + 50);
    };

    //end 30 day items
    //end item info

    //triggers reset function and back button to bring back to home screen
    if (mousePressed) { 

      if (mouseX > 20 && mouseX < 70 && mouseY > 20 && mouseY < 70) { //logo acts as home button
        reset();
      };
      if ( mouseX > 40 && mouseX < 55 && mouseY > 230 && mouseY < 250) { //x button acts as home button
        reset();
      };
    };
    //end trigger
  };
};

void fadesIn() { //text fade in

  if (fadeIn > 256)
    return;
  fill(gray, fadeIn);
  fadeIn++;
};


//void fadesOut() { //text is supposed to fade out but it didn't work after about 24 hours of trying
//  if (fadeOut < 1)
//  return;
//    fill(gray, fadeOut);
//    fadeOut --;
//};


void ingredients(int n) {

  selected = cp5.get(ScrollableList.class, "ingredients").getItem(n).get("name").toString(); //gets item name based on list class

  if (selected != null) { //uses item selection to pick which item date screen to show up
    itemDate = true; //makes item date screen show
    home = false; //makes home screen hide, which allows item dates screen visibility
  };
};

//string for math to add correspoding expiry dates 
String addToDate(int days, int hours) {
  Date todaysDate = new Date();
  // String formattedDate = newFormat.format(todaysDate);

  Calendar newCalDate = Calendar.getInstance();
  newCalDate.setTime(todaysDate);

  newCalDate.add(Calendar.DATE, days);
  newCalDate.add(Calendar.HOUR, hours);

  Date returnDate = newCalDate.getTime();
  String returnString = newFormat.format(returnDate);

  return returnString;
};
//end date math string

//function that resets all parametres
void reset() {
  //fadesOut();
  home = true;
  itemDate = false;
  selected = null;
  fadeIn = 0;
  fadeOut = 255;
}
