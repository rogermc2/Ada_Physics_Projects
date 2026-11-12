
--  with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

with Utilities; use Utilities;

package body Monte_Carlo_Lib is

   Gen    : Generator;
   Seed_1 : Integer;
   Seed_2 : Integer;
   Seed_3 : Integer;

   function Gauss_Smear (X : Float; DX : Float) return Float is
   begin
      --  Value + (Standard Normal Deviate * Uncertainty)
      return X + (Random_Gaussian_Deviate (Gen) * DX);

   end Gauss_Smear;

   procedure Get_Random_Deviate_Seed (SA, SB, SC : out Integer) is
   begin
      SA := Seed_1;
      SB := Seed_2;
      SC := Seed_3;

   end Get_Random_Deviate_Seed;

   --   Equivalent to Bevington's Gaussian deviate generator
   function Random_Gaussian (Mean : Float := 0.0; Std_Dev : Float := 1.0)
            return Float is
      U1    : Uniformly_Distributed := 0.0;
      U2    : Uniformly_Distributed;
      R     : Float;
      Theta : Float;
      Z0    : Float;
      --  Note: Box-Muller generates two independent numbers  (Z0 and Z1).
      --  For a simple functional interface generate both and return one.
   begin
      --  Prevent taking the log of absolute 0.0
      while U1 <= 0.0 loop
         U1 := Random (Gen);
      end loop;
      U2 := Random (Gen);

      --  Box-Muller Transformation
      R := Sqrt (-2.0 * Log (Float (U1), Base => e));
      Theta := 2.0 * Pi * Float (U2);

      --  standard normal distribution (Mean=0, Std_Dev=1)
      Z0 := R * Cos (Theta);
      --  Scale and shift to match desired Gaussian parameters
      return Mean + (Z0 * Std_Dev);

   end Random_Gaussian;

   function Random_Deviate return Float is
      Sum : Float;
   begin
      Seed_1 := 7 * Seed_1 mod (177) - 2 * Seed_1 / 177;
      if Seed_1 < 0 then
         Seed_1 := Seed_1 + 30269;
      end if;

      Seed_2 := 172 * Seed_2 mod (76) - 35 * Seed_2 / 176;
      if Seed_2 < 0  then
         Seed_2 := Seed_2 + 30307;
      end if;

      Seed_3 := 170 * Seed_3 mod (178) - 63 * Seed_3 / 78;
      if Seed_3 < 0 then
         Seed_3 := Seed_3 + 30323;
      end if;

      Sum := Float (Seed_1) / 30269.0 + Float (Seed_2) / 30307.0 +
            Float (Seed_3) / 30323.0;

      return Get_Fractional_Part (Sum);

   end Random_Deviate;

   --  Equivalent to Bevington's Gaussian deviate generator
   function Random_Gaussian_Deviate (Gen : in out Generator) return Float is
      U1    : Uniformly_Distributed := 0.0;
      U2    : Uniformly_Distributed;
      R     : Float;
      Theta : Float;
   begin
      while U1 <= 0.0 loop
         U1 := Random (Gen);
      end loop;
      U2 := Random (Gen);

      R := Sqrt (-2.0 * Log (Float (U1), Base => e));
      Theta := 2.0 * Pi * Float (U2);

      return R * Cos (Theta);

   end Random_Gaussian_Deviate;

   procedure Set_Random_Deviate_Seed (SA, SB, SC : Integer) is
   begin
      Seed_1 := SA;
      Seed_2 := SB;
      Seed_3 := SC;

   end Set_Random_Deviate_Seed;

begin
      --  Initialize seed with a fixed initiator for
      --  deterministic/reproducible results
      --  (Equivalent to CALL SETRANDOMDEVIATESEED(s1, s2, s3))
      Reset (Gen, Initiator => 42195);

end Monte_Carlo_Lib;