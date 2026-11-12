
with Ada.Text_IO; use Ada.Text_IO;

with Monte_Carlo_Lib; use Monte_Carlo_Lib;
procedure Hot_Rod_Temperature is
   S1      : constant Integer := 1171;
   S2      : constant Integer := 343;
   S3      : constant Integer := 1322;
   Sig_Mat : constant Float := 1.0;
   T       : Float;
   T_Prime : Float;
   X       : Float := -0.5;
   Num     : constant Integer := 5;
begin
   Set_Random_Deviate_Seed (S1, S2, S3);

   Put_Line ("Hot rod test data, sigma: " & Float'Image (Sig_Mat));
   Put_Line ("         X           T           T'");
   for count in 1 .. Num loop
      X := X + 1.0;
      T := 10.0 * X;
      T_Prime := Gauss_Smear (T, Sig_Mat);
         Put_Line (Integer'Image (count) & " " & Float'Image (X) &
                  Float'Image (T) & Float'Image (T_Prime));
   end loop;

end Hot_Rod_Temperature;
