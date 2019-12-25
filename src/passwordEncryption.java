import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

/**
 * 
 */

/**
 * @author User
 *
 */
public class passwordEncryption {

	/**
	 * @param args
	 * @throws NoSuchAlgorithmException 
	 */
	public static void main(String[] args) throws NoSuchAlgorithmException {
		// TODO Auto-generated method stub
		 Scanner in = new Scanner(System.in);  
		 System.out.print("Password: ");  
         String password = in.next();  
		 MessageDigest md = MessageDigest.getInstance("MD5");
	        md.update(password.getBytes());
	 
	        byte byteData[] = md.digest();
	 
	        //convert the byte to hex format
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
	     System.out.println("\n\n" + sb.toString());
	}

}
