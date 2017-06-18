with Ada.Text_Io, Ada.Strings.Unbounded,Ada.Integer_Text_IO,Ada.Unchecked_deallocation;
use Ada.Text_Io, Ada.Strings.Unbounded,Ada.Integer_Text_IO;

package body Tree is

   procedure Liberer is new Ada.Unchecked_Deallocation(Node,Tree);

   procedure Free(T:in out Tree) is
   begin
      if T= null then
         return;
      end if;

      if T.Val ='z' then
         Clear(T.Liste); --Liberation des listes.
         Liberer(T); --Liberation des noeuds terminaux.
         return;
      end if;

      for I in T.Fils'Range loop
         Free(T.Fils(I));
      end loop;
      Liberer(T); --Libération Des noeuds
      return;
   end Free;
---------------------------------------------------------------------------------------
   function New_Tree return Tree is
      Arbre:Tree:=new Node;
   begin
      Arbre.Val:='`'; --Caractère avant le 'a' dans le code ASCII.
      return Arbre;
   end New_Tree;
----------------------------------------------------------------------------------------
   function Compter_Lettre(Word: in String; C: in Character) return Natural is
      Compteur : Natural := 0;
   begin
      for I in Word'Range loop

         if Word(I) = C then
            Compteur := Compteur + 1;
         end if;

      end loop;
      return Compteur;
   end Compter_Lettre;
----------------------------------------------------------------------------------------
   procedure Insertion(T: in out Tree; Word: in String) is
      L: Natural;
   begin

      if T.Val = 'z' then
         if Find(T.Liste,To_Unbounded_String(Word)) = No_element then
            insert(T.Liste,No_Element,To_Unbounded_String(Word)); --Convertion en type non-contraint.
         end if;
         return;
      end if;

      L := Compter_Lettre(Word,Character'Val(Character'Pos(T.Val) + 1)); --Nombre de lettres suivantes.

      if T.Fils(L)=null  then
         T.Fils(L) := new Node;
         T.Fils(L).Val := Character'Val(Character'Pos(T.Val) + 1);
      end if;

      Insertion(T.Fils(L), Word);

   exception

      when CONSTRAINT_ERROR => --Cas où on a trop de lettre identique dans un mot (débordement du tableau).
         Put("Trop de lettres identiques, insertion annulée du mot :");
         Put(Word);
         New_Line;
         return;

   end Insertion;
-----------------------------------------------------------------------------------------
   procedure Search_And_Display(T: in Tree; Letters: in String) is
      L : Natural := 0;
      Indice:Cursor;
   begin

      if T.Val = 'z' then

         if not Is_Empty(T.Liste) then

            Indice:=First(T.Liste);

            while Indice /= No_Element loop --Affichage des éléments de la liste si elle n'est pas vide.
               Put(To_String(Element(indice)));
               New_Line;
               Next(Indice);
            end loop;
         end if;

         return;

      end if;

      L := Compter_Lettre(Letters,Character'Val(Character'Pos(T.Val) + 1));

      for I in 0..L loop

         if T.Fils(I) /= null then --Verification de l'existence du fils.
            Search_And_Display(T.Fils(I),Letters);
         end if;

      end loop;

   exception
      when CONSTRAINT_ERROR => -- Si on recherche un mot avec un nombre de lettres identiques trop important.
         return;

   end Search_And_Display;

end Tree;
