# 2-1: Hračkárstvo

**Assignment:**
>Jakubko sa rád hrá a potrebuje stále nové hračky. V hračkárstve si všimol, že drahšie hračky sú zvyčajne komplikovanejšie a preto sa mu viac páčia. Chcel by zistiť, či majú rodičia dosť peňazí na nákup K najdrahších hračiek v obchode. Pomôžte Jakubkovi zistiť koľko peňazí by potreboval.

>Vašou úlohou je napísať funkciu, ktorá ako vstupný argument dostane pole cien hračiek v obchode, ich počet N, a číslo K -- koľko hračiek si chce Jakubko z obchodu kúpiť, a vypočíta súčet cien K najdrahších hračiek v obchode.

>Naprogramujte funkciu v nasledovnom tvare: \
>// urci sucet k najvacsich cisel z cisel cena[0],...,cena[n-1] \
>long sucet_k_najvacsich(int cena[], int n, int k);

>**Príklad postupnosti:** \
>N = 6, K = 4 \
>10 9 8 1 2 3

>**Výsledok (10+9+8+3):** \
>30

>Algoritmus, ktorý usporiada ceny štandardným algoritmom v čase O(N log N) je pomalý. Riešenie musí bežať v čase O(N + K).
