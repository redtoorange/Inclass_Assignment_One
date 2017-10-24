with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure Main is
   type Data_Entry is record
      length : Integer := 0;
      word   : String(1..80);
      count  : Integer := 0;
   end record;

   type Word_Array is array(Natural range <>) of Data_Entry;

   procedure Add_Word( word_list : in out Word_Array;
                       s : in String;
                       count : in out Integer;
                      len : in Integer)
   is
      unique : Boolean := True;
   begin
      for i in 1..count loop
         if word_list(i).word(1..len) = s(s'First..len) then
            word_list(i).count := word_list(i).count + 1;
            unique := False;
         end if;
         exit when not unique;
      end loop;

      if unique then
         count := count + 1;

         word_list(count).length := len;
         word_list(count).word(1..len) := s(s'First..len);
         word_list(count).count := 1;
      end if;
   end Add_Word;


   words : Word_Array(1..1000);
   s     : String(1..80);
   count : Integer := 0;
   len   : Integer := 0;
   max_len : Integer := 10;
begin
   while not End_Of_File loop
      Get_Line(s, len);

      if len + 2 > max_len then
         max_len := len + 2;
      end if;

      Add_Word(words, s, count, len);
   end loop;

   for i in 1..count loop
      Put( words(i).word(1..words(i).length) );
      Set_Col( 15 );
      Put( words(i).count, 0);
      New_Line;
   end loop;


end Main;
