
class selectedCategoryHelper{
  
static Map<String,dynamic>getCategoriesStyle(String category){
  String imagePath;
  switch(category){
    case 'Design':
      imagePath='images/icons/sketch.png';
    break;
    case 'Coding':
    
      imagePath='images/icons/code.png';
      
    break;
    case 'Development':
    
      imagePath='images/icons/growth.png';
    break;
    case 'Meeting':
      imagePath='images/icons/video-call.png' ;
    break;
    case 'Work':
      imagePath='images/icons/suitcase.png';
    break;
    case 'Meditation':
      imagePath='images/icons/meditation.png';
      break;
    case 'Fitness':
     imagePath= 'images/icons/warming.png';
      break;
    case 'Relaxing time':
      imagePath='images/icons/procrastination.png';
    break;
   default:
      imagePath='images/icons/suitcase.png';
  }
    return {
      'image':imagePath
    };
  }

}
