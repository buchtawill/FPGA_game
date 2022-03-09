package imageToVerilogRom;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;

public class process {

	public static void main (String[] args) throws IOException{
		String path = "mario";
		File original = new File(path+".png");
		BufferedImage img = null;
		FileWriter writer = new FileWriter("output.txt");
		///////////////////////////
		boolean moveable = false;
		int BACKGROUND = 4095;
		///////////////////////////
		int r,g,b, color_val;
		try {
			img = ImageIO.read(original);

			int height = img.getHeight();
			int width  = img.getWidth();

			int h_bits = (int)Math.round((Math.log((double)height) / Math.log(2)) - 1);
			int w_bits = (int)Math.round((Math.log((double)width) / Math.log(2)) - 1);

			writer.write("module "+path+ "_rom(     //"+width+" x "+height+" pixels\n"
					+ "	input wire        clk,\n"
					+ "	input wire ["+w_bits+":0]  col,\n"
					+ "	input wire ["+h_bits+":0]  row,\n"
					+ "	output reg [11:0] color_val,\n"
					+ "	output wire       valid\n"
					+ "	);\n\n"
					+ "	reg ["+w_bits+":0] colReg;\n"
					+ "	reg ["+h_bits+":0] rowReg;\n"
					+ "	reg                validReg; //if not background color\n"
					+ "	assign valid = validReg;\n\n"
					+ "	always @ (posedge clk)begin\n"
					+ "		rowReg <= row;\n"
					+ "		colReg <= col;\n"
					+ "	end\n\n"
					+ "	always @(row,col) validReg <= 1;\n\n"
					+ "	always @*\n"
					+ "	case({rowReg, colReg})\n"
					+ "");
			if(!moveable) {
				System.out.println("static rom");
				for(int i = 0; i < height; i++) {
					for(int j = 0; j < width; j++) {
						Color c = new Color(img.getRGB(j, i));
						r = c.getRed()/17;
						g = c.getGreen()/17;
						b = c.getBlue()/17;
						color_val = r<<8 | g << 4 | b;
						if(color_val!=BACKGROUND)	//optimization to save space. If 4095, it will default
							writer.write("	    "+(w_bits+h_bits+2)+"'d"+(i<<(w_bits+1) | j)+": color_val = 12'd" +color_val+";\n");	//i is row(y), j is col(x)
					}
				}
			}
			else {	//if moveable
				System.out.println("sprite");
				for(int i = 0; i < height; i++) {
					for(int j = 0; j < width; j++) {
						Color c = new Color(img.getRGB(width-j-1, height-i-1));
						r = c.getRed()/17;
						g = c.getGreen()/17;
						b = c.getBlue()/17;
						color_val = r<<8 | g << 4 | b;
						if(color_val!=BACKGROUND)	//optimization to save space. If 0, it will default
							writer.write("	    "+(w_bits+h_bits+2)+"'d"+(i<<(w_bits+1) | j)+": color_val = 12'd" +color_val+";\n");	//i is row(y), j is col(x)
					}
				}
			}
			writer.write("\n		default:  validReg <= 0;\n		endcase\n\nendmodule //"+path+"_rom");


			writer.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}


}
