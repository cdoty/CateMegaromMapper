# Cate Megarom Mapper for the CATE compiler.
A Cate compiler project demonstrating a Coleco Megarom mappter using the [CATE](https://github.com/inufuto/Cate) compiler.
The code was created because CATE lacks native support for banking and is a limiting factor in it's use for larger projects.

Location $8000-$BFFF is used as fixed bank 0 and location $C000-$FFFF is used for swappable banks. The tool abuses the zero segment feature of CATE to compile the fixed bank to zseg when compiling the additional banks. This is accomplished by compiling the fixed bank code with a wrapper file specifying cseg or zseg as the target.
Each bank is compiled with a callable function to call internal functions.
Once all of the banks are compiled, they must be concatenated together into a ROM file, and padding to a set size.
The first bank must be the last bank in the ROM file. The rest of banks start from 0 instead of 1, the renumbering is handled in the callBankFunction().

There are 8 locations that can be used to share information across bank. They can either store bytes or words.

You will need to download the [Tools repo](https://github.com/cdoty/Tools) and place it in a folder with the CateMegaromMapper folder.