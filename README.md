This project is an illustration of the problem I'm having while rendering `CIImage` that is smaller in size than `CAMetalDrawable`'s texture.

I'd expect the rendered image to be centered in the drawable, instead it is rendered at the texture's origin.

You need a metal-capable iOS device to run this project.

![Alt text](problem%20screenshot.png)
