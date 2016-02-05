$(document).ready(function(){

  var SlideMenu = function(selector) {
    this.selector = selector;
    this.element = function(){
      return $(this.selector);
    };
    this.currentWidth = function() {
      return this.element().width();
    };
    this.minWidth = this.element().width();
    this.maxWidth = this.minWidth + 75;
    this.toggle = function(){
     if(this.currentWidth() == this.minWidth) {
        this.element().animate({width: this.maxWidth}, function(){
          $('.menu-label').fadeIn();
        });
     } else {
       $('.menu-label').fadeOut(function(){
         slideMenu.element().animate({width: slideMenu.minWidth});
       });
     }
      return true;
    };
    this.element();
  };

  var slideMenu = new SlideMenu('.slide-menu');
  var slideMenuIcons = new SlideMenu('.slide-menu');

  document.logout = function(path){
    $.ajax({
      type: "DELETE",
      url: path
    }).done(function() {
      window.location = '/';
    });
  };

  document.toggleSlideMenu = function () {
    slideMenu.toggle('.slide-menu');
    slideMenuIcons.toggle('.slide-menu i');
  };
});
