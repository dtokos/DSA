# 2: Vyhľadávanie v dynamických množinách

**Assignment:**
>Existuje veľké množstvo algoritmov, určených na efektívne vyhľadávanie prvkov v dynamických množinách: binárne vyhľadávacie stromy, viaceré prístupy k ich vyvažovaniu, hashovanie a viaceré prístupy k riešeniu kolízii. Rôzne algoritmy sú vhodné pre rôzne situácie podľa charakteru spracovaných údajov, distribúcii hodnôt, vykonávaným operáciám, apod. V tomto zadaní máte za úlohu implementovať
a porovnať tieto prístupy.

>Vašou úlohou v rámci toho zadania je porovnať viacero implementácií dátových štruktúr z hľadiska efektivity operácii insert a search v rozličných situáciách. Operáciu delete nemusíte implementovať.

> - Vlastnú implementáciu binárnych vyhľadávacích stromov (BVS) bez vyvažovania.
> - (2 body) Vlastnú implementácia niektorého (podľa vlastného výberu) algoritmu pre vyvažovanie BVS, napr. AVL, Červeno-Čierne stromy, (2,3) stromy, (2,3,4) stromy, Splay stromy, ...
> - (1 bod) Prevzatú (nie vlastnú!) implementáciu iného algoritmu na vyvažovanie BVS. Iný algoritmus ako v predchádzajúcom bode. Zdroj musí byť uvedený.
> - (2 bod) Vlastnú implementáciu hashovania s riešením kolízií podľa vlastného výberu. Treba implementovať aj operáciu zväčšenia hashovacej tabuľky.
> - (1 bod) Prevzatú (nie vlastnú!) implementáciu hashovania s riešením kolízii iným spôsobom ako v predchádzajúcom bode. Zdroj musí byť uvedený.

>Za implementácie podľa vyššie uvedených bodov môžete získať 6 bodov. Každú implementáciu odovzdáte v jednom samostatnom zdrojovom súbore (v prípade, že chcete odovzdať všetky štyri, tak odovzdáte ich v štyroch súboroch). Vo vlastných implementáciách nie je možné prevziať cudzí zdrojový kód. Pre úspešné odovzdanie musíte zrealizovať aspoň dve z vyššie uvedených implementácií – môžete teda napr. len prevziať existujúce (spolu 2 body), alebo môžete aj prevziať existujúce aj implementovať vlastné (spolu 6 bodov). Správnosť overte testovaním-porovnaním s inými, nasledovne:

>V technickej dokumentácii je vašou úlohou zdokumentovať vlastné aj prevzaté implementácie, a uviesť podrobné scenáre testovania, na základe ktorých ste zistili, v akých situáciách sú ktoré z týchto implementácií efektívnejšie. Vyžaduje to tiež odovzdanie programu, ktorý slúži na testovanie a odmeranie efektívnosti týchto implementácii ako jedného samostatného zdrojového súboru. Za dokumentáciu, testovanie a dosiahnuté výsledky (identifikované vhodné situácie) môžete získať najviac 4 body. Hodnotí sa kvalita spracovania.

>Minimálny celkový počet bodov pre úspešné absolvovanie tohto zadania je 4 body.

>**Prvú funkčnú verziu je potrebné odovzdať do 3.11.2019 do 21:00.**
>Verziu po dopracovaní pripomienok cvičiaceho odovzdať do **10.11.2019 21:00.**
