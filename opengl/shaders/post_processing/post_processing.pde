Home
About
RSS Feed
Shaders in Processing 2.0 – Part 2   9 comments
The new capability of loading user-provided GLSL shaders into Processing’s P2D and P3D renderers opens up the possibility of customizing all the rendering operations in Processing, as well as of creating interactive graphics that would be very hard or impossible to generate otherwise. For OpenGL web applications, WebGL supports (only) programmable pipelines through GLSL shaders, and this has motivated the creation of online repositories of shader effects that can be run directly from inside the web browsers, as long as they support WebGL. Sites like the GLSL sandbox or Shader Toy hold large collections of shader effects that can be edited and controlled interactively through the browser. This new post will explain how to integrate GLSL shaders from the GLSL sandbox and Shader Toy websites into a Processing sketch.
Update: The shader API changed slightly in the betas, please refer to this post for more information.
PShader blur;

void setup() {
  size(400, 400, P2D);
  blur = loadShader("blur.glsl"); 
}

void draw() {
  rect(mouseX, mouseY, 50, 50);    
  filter(blur);    
}

