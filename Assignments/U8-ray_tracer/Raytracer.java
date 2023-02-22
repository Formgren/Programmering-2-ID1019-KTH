import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class Raytracer {
    private static final int WIDTH = 800;
    private static final int HEIGHT = 600;

    public static void main(String[] args) {
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);

        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                Color color = traceRay(x, y);
                image.setRGB(x, y, color.getRGB());
            }
        }

        try {
            File output = new File("output4.png");
            ImageIO.write(image, "png", output);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static Color traceRay(int x, int y) {
        double originX = 0;
        double originY = 0;
        double originZ = 0;

        double directionX = x - WIDTH / 2;
        double directionY = y - HEIGHT / 2;
        double directionZ = 10;

        double distance = Math.sqrt(directionX * directionX + directionY * directionY + directionZ * directionZ);

        directionX /= distance;
        directionY /= distance;
        directionZ /= distance;

        double t = intersectSphere(originX, originY, originZ, directionX, directionY, directionZ, 200);

        if (t > 0) {
            // Get the x and y coordinates of the intersection point
            double intersectionX = originX + directionX * t;
            double intersectionY = originY + directionY * t;
            // Use the x and y coordinates to determine the color of the sphere
            int red = (int) ((Math.abs(intersectionX) / 200) * 255);
            int green = (int) ((Math.abs(intersectionY) / 200) * 255);
            int blue = 0;
            return new Color(red, green, blue);
        }
    
        return Color.BLACK;
    }

    private static double intersectSphere(double originX, double originY, double originZ, double directionX, double directionY, double directionZ, double radius) {
        double a = directionX * directionX + directionY * directionY + directionZ * directionZ;
        double b = 2 * (directionX * originX + directionY * originY + directionZ * originZ);
        double c = originX * originX + originY * originY + originZ * originZ - radius * radius;

        double discriminant = b * b - 4 * a * c;

        if (discriminant < 0) {
            return -1;
        }

        double t1 = (-b + Math.sqrt(discriminant)) / (2 * a);
        double t2 = (-b - Math.sqrt(discriminant)) / (2 * a);

        if (t1 < 0) {
            t1 = Double.MAX_VALUE;
        }

        if (t2 < 0) {
            t2 = Double.MAX_VALUE;
        }

        return Math.min(t1, t2);
    }
}
