
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package Monte_Carlo_Lib is

   function Gauss_Smear (X : Float; DX : Float) return Float;
   function Gaussian_Smear (X, X0 : Float; Sigma : Float := 1.0)
      return Float;
   procedure Get_Random_Deviate_Seed (SA, SB, SC : out Integer);
   function Random_Gaussian (Mean : Float := 0.0; Std_Dev : Float := 1.0)
      return Float;
   function Random_Gaussian_Deviate (Gen : in out Generator) return Float;
   procedure Set_Random_Deviate_Seed (SA, SB, SC : Integer);

end Monte_Carlo_Lib;