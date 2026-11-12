
package body Utilities is

   function Get_Fractional_Part (X : Float) return Float is
      Result : Float;
   begin
      Result := X - Float (Integer (X));
      if Result < 0.0 then
         Result := Result + 1.0;
      end if;

      return Result;

   end Get_Fractional_Part;

end Utilities;
