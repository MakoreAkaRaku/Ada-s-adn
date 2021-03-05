with Ada.Text_IO;use Ada.Text_IO;
procedure Main is
   type ch_array is array(0..9999) of Character;
   type p_array is access ch_array;
   type tadn is record
      cadena1: p_array;
      cadena2: p_array;
      tamany: Integer;
   end record;
   type file is record
      length: Integer;
      file_d: file_type;
      buffer: ch_array;
   end record;
   procedure read_file(archive: in out file) is
      filename: constant String := "CDS_LRRTM1_humano.txt";
   begin
      archive.length := 0;
      open(archive.file_d,In_File,filename);
      while End_Of_File(archive.file_d) /= TRUE loop
         Get(archive.file_d, archive.buffer(archive.length));
         archive.length:= archive.length+1;
      end loop;
      archive.length := archive.length-1;
      Close(archive.file_d);
   end read_file;

   procedure construir_adn(tipus_adn:  in out tadn) is
      max : constant Integer := 50;
      n,m: Integer := 0;
   begin
      n:= tipus_adn.tamany;
      while n >= 0 loop
         case tipus_adn.cadena1(m) is
         when 'T' =>
            tipus_adn.cadena2(m) := 'A';
         when 'C' =>
            tipus_adn.cadena2(m) := 'G';
         when 'A' =>
            tipus_adn.cadena2(m) := 'T';
         when 'G' =>
            tipus_adn.cadena2(m) := 'C';
         when others => null;
         end case;
         n:= n-1;
         m:= m+1;
      end loop;
   end construir_adn;
   marc_adn: tadn;
   arxiu: file;
begin
   read_file(arxiu);
   marc_adn.cadena1 := new ch_array;
   marc_adn.tamany := arxiu.length;
   for I in 0..arxiu.length loop
      marc_adn.cadena1(I):= arxiu.buffer(I);
   end loop;
   marc_adn.cadena2 := new ch_array;
   construir_adn(marc_adn);

   Put_Line("Resultat: ");
   Put_Line("Cadena 1: ");
   for I in 0..marc_adn.tamany loop
      Put(marc_adn.cadena1(I));
   end loop;
   Put_Line("");
   Put_Line("Cadena 2: ");
      for I in 0..marc_adn.tamany loop
      Put(marc_adn.cadena2(I));
   end loop;
end Main;
