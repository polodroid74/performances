with Ada.Strings.Unbounded, Ada.Text_Io, Ada.Containers.Doubly_Linked_Lists;
use Ada.Strings.Unbounded, Ada.Text_Io, Ada.containers;

package Tree is


   package words_list is new Ada.Containers.Doubly_Linked_Lists(Unbounded_String) ;
   use words_list;


   type Tree is private;
   type Tab is array(0..15) of Tree;
   function New_Tree return Tree;
   procedure Insertion(T : in out Tree ; Word : in String);
   procedure Search_And_Display(T : in Tree ; Letters : in String);
   function Compter_Lettre(Word: in String; C: in Character) return Natural; --Compte le nombre d'apparition d'une lettre spécifiée dans un mot.
   procedure Free(T:in out Tree); --libère la structure de donnée(arbre et listes de mots) allouée.
private

   type Node;
        type Tree is access Node;
        type Node is record
           Val : Character:='?'; -- caractère arbitraire permettant l'initialisation.
           liste : List;
           Fils:Tab:=(others=>null); --tableau de pointeurs initialisé à null.
        end record;
end Tree;
