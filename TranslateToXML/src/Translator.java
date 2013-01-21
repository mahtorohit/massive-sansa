import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class Translator {
	
	public static void main(String[] args) throws IOException {
		
		System.out.println("Parsing " + args[0]);
		
		BufferedReader r = new BufferedReader(new InputStreamReader(new FileInputStream(
				args[0]), "UTF-8"));
		BufferedWriter w = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
				args[0] + ".xml"), "UTF-8"));
		
		String last = null;
		int lastlevel = 0;

		String now = null;
		int nowlevel = 0;

		w.write("<items>\n");
		w.flush();
		while ((now = r.readLine()) != null) {

			if (last == null) {
				last = now;
				continue;
			}

			lastlevel = countTabs(last);
			nowlevel = countTabs(now);

			if (lastlevel < nowlevel) {
				w.write(tabs(lastlevel) + "<item name=\"" + nameOf(last) + "\" img=\"" + imgOf(last) + "\">\n");
				w.flush();
			} else if (lastlevel == nowlevel) {
				w.write(tabs(lastlevel) + "<item name=\"" + nameOf(last) + "\" img=\"" + imgOf(last) + "\"/>\n");
				w.flush();
			} else if (lastlevel > nowlevel) {
				w.write(tabs(lastlevel) + "<item name=\"" + nameOf(last) + "\" img=\"" + imgOf(last) + "\"/>\n");
				w.flush();

				for (int i = lastlevel; i > nowlevel; i--) {
					w.write(tabs(i - 1) + "</item>\n");
					w.flush();
				}
			}

			last = now;
		}

		lastlevel = countTabs(last);
		nowlevel = 0;
		
		w.write(tabs(lastlevel) + "<item name=\"" + nameOf(last) + "\" img=\"" + imgOf(last) + "\"/>\n");
		w.flush();

		for (int i = lastlevel; i > nowlevel; i--) {
			w.write(tabs(i - 1) + "</item>\n");
			w.flush();
		}

		w.write("</items>");
		w.flush();
		
		System.out.println("Created " +  args[0] + ".xml");
	}

	private static String tabs(int c) {
		String s = "";
		for (int i = 0; i <= c; i++) {
			s += "\t";
		}
		return s;
	}

	private static int countTabs(String s) {
		int c = 0;
		while (s.startsWith("\t")) {
			c++;
			s = s.substring(1);
		}
		return c;
	}

	private static String nameOf(String s) {
		s = s.substring(countTabs(s));
		return s.split(";")[0];
	}

	private static String imgOf(String s) {
		s = s.substring(countTabs(s));
		return s.split(";").length > 1 ? s.split(";")[1] : "" ;
	}
}
