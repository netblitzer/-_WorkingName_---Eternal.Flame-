// thread class for loading in files on a seperate thread

class TextureLoader extends Thread {
  
  ArrayList<PImage> loadedTextures;
  ArrayList<String> filesLeftToLoad;
  
  public TextureLoader(ArrayList<PImage> IList, ArrayList<String> filesToLoad) {
    loadedTextures = IList;
    filesLeftToLoad = (ArrayList<String>) filesToLoad.clone();
  }
  
  // Goes through the current task list and loads them all in order placed
  public void run() {
    while(filesLeftToLoad.size() > 0) {
      loadedTextures.add(loadImage("textures/" + filesLeftToLoad.remove(0)));
    }
  }
}