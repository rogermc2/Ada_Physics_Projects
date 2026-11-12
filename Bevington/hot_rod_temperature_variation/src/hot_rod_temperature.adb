
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
   Put_Line
      ("Simulating 5 physical science measurement noise fluctuations" &
         " (Mean=0.0, Std_Dev=1.5):");
   for I in 1 .. 5 loop
      declare
         Noise : constant Float :=
            Random_Gaussian (Mean => 0.0, Std_Dev => 1.5);
         Reds  : constant String := Float'Image (Noise);
      begin
         Put_Line ("  Measurement Deviate" & Integer'Image (I) &
                     ":" & Reds);
      end;
   end loop;

   Set_Random_Deviate_Seed (S1, S2, S3);
   for count in 1 .. Num loop
      X := X + 1.0;
      T := 10.0 * X;
      T_Prime := Gauss_Smear (T, Sig_Mat);
   end loop;

end Hot_Rod_Temperature;
