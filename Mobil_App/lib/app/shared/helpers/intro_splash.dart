import 'package:flutter/material.dart';

class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Kan ihtiyaçtır , yaşamak ve yaşatmak için...");
  sliderModel.setTitle("Kan Dostum");
  sliderModel.setImageAssetPath("assets/kndstm_logo.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Yakınınında bulunan kan ihtiyaçlarını gör...");
  sliderModel.setTitle("Kan Dostum");
  sliderModel.setImageAssetPath("assets/notificationBlood.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("asd.");
  sliderModel.setTitle("merhaaba");
  sliderModel.setImageAssetPath("assets/joinus.png");
  slides.add(sliderModel);

  //4
  sliderModel.setDesc("Kan vermek sağlığınız için de gereklidir. Kan dostu olmaya...\n Kan vermek için de hastalığının olmamasını unutma.");
  sliderModel.setTitle("Kan Dostum");
  sliderModel.setImageAssetPath("assets/joinus.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}