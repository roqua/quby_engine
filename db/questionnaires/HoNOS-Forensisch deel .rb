"HoNOS-Forensisch deel" 

abortable

panel do
 title "HoNOS-Forensisch deel"
 text <<-END.gsub(/^ {4}/, '')
    * Verzamel de meest complete klinische geschiedenis en het risico profiel dat beschikbaar is van de zorggebruiker

    * Beoordeel de incidenten die hebben plaatsgevonden, het gedrag en de houding, de vooruitgang die nu wordt geboekt, etc..

    * Beoordeel het meest ernstige potentiële probleem in de nabije toekomst (weken of maanden), ook als de zorggebruiker zelfstandig zonder begeleiding in de maatschappij leeft.  ‘Potentieel’ moet hier worden opgevat als een aanmerkelijke kans op voorkomen van het probleem. Als de uitkomst onvoorspelbaar is (bijv. overdosis of brandstichting), maak dan de beoordeling in overeenstemming met het risico dat dit zal gebeuren

    * Vervolgens, scoor de risico beoordeling en de *huidige* behoefte aan beveiliging. 
Opm – dit kan maar hoeft niet overeen te komen met de zorg zoals die nu wordt geboden!
  END
end

panel do
question :v_1, :type => :radio, :required => true do
  title "A.	Scoor risico op schade toegebracht aan volwassenen en kinderen"
  option :a1, :value => 0, :description => "0.	niet aanwezig"

  option :a2, :value => 1, :description => "1.	 Laag - bijv. ruzie; sexueel vergrijp zonder aanraking; schade toegebracht aan voorwerpen; in de brand steken van afval"

  option :a3, :value => 2, :description => "2.	*Behoorlijk*-  verwonding; brandstichting; sexueel geweld"

  option :a4, :value => 3, :description => "3.	*Ernstig*- verwonding; levensbedreigende brandstichting; verkrachting; toebrengen blijvend letsel"

  option :a5, :value => 4, :description => "4.	*Zwaar*- doodslag, bijna fatale verwondingen, ernstige trauma"
end

question :v_2, :type => :radio, :required => true do
  title "B.	Scoor risico op zelf beschadiging (opzettelijk of per ongeluk)"
  option :a1, :value => 0, :description => "0.	niet aanwezig"

  option :a2, :value => 1, :description => "1.	Laag-geringe zelfbeschadiging/overdosis; verwaarlozing van de hygiëne;  ondervoeding"

  option :a3, :value => 2, :description => "2.	Behoorlijk-verwonding of misvorming; opname vanwege overdosis; brandwonden; uithongering, etc"

  option :a4, :value => 3, :description => "3.	Ernstig-handicap als gevolg van zelfbeschadiging"

  option :a5, :value => 4, :description => "4.	Zwaar-suicide poging; springen vanaf hoge objecten "
end

question :v_3, :type => :radio, :required => true do
  title "C.	Score behoefte aan beveiliging om relapse te voorkomen"
  option :a1, :value => 0, :description => "0.	open woonvoorziening in de wijk/dorp"

  option :a2, :value => 1, :description => "1.	open woonvoorziening op terrein van psychiatrische inrichting"

  option :a3, :value => 2, :description => "2.	Geringe beveiliging-beperking in bewegingsvrijheid met beveiligingsmaatregel; hoge afhankelijkheid"

  option :a4, :value => 3, :description => "3.	Gemiddelde beveiliging- gebouw en omgeving met beveiliging"

  option :a5, :value => 4, :description => "4.	Zware beveiliging- beveiliging komt overeen met die van een gevangenis of TBS kliniek "
end

question :v_4, :type => :radio, :required => true do
  title "D.	Scoor behoefte aan toezicht in de leefomgeving"
  option :a1, :value => 0, :description => "0.	geen behoefte - woonvoorziening zonder staf is voldoende"

  option :a2, :value => 1, :description => "1.	Dagbehandeling; thuisbehandeling; 24-uurs zorg/opname, maar mag onbegeleid dorp of stad in"

  option :a3, :value => 2, :description => "2.	24-uurs zorg/opname met uitsluitend begeleide bewegingsvrijheid buiten de instelling"

  option :a4, :value => 3, :description => "3.	uitgebreide/continue/speciale observatie maatregel"

  option :a5, :value => 4, :description => "4.	af en toe/frequent in isoleercel is nodig; continue betrokkenheid van meer dan één staflid"
end
end

panel do
question :v_5, :type => :radio, :required => true do
  title "E.	Scoor behoefte aan begeleiding bij proefverlof (includeer niet de andere behoeften, zoals een taxi chauffeur)"
  option :a1, :value => 0, :description => "0.	geen indicatie voor ontsnapping; iemand informeren is voldoende; gedraagt zich naar behoren"

  option :a2, :value => 1, :description => "1.	Eén begeleider - patient kan verdwalen; te laat terug komen; onder de voet worden gelopen; zich onbehoorlijk gedragen"

  option :a3, :value => 2, :description => "2.	Maximaal twee begeleiders om gedrag te beheersen of ontsnapping te voorkomen"

  option :a4, :value => 3, :description => "3.	maximaal drie begeleiders om gedrag te beheersen of ontsnapping te voorkomen"

  option :a5, :value => 4, :description => "4.	Speciale aanpak is nodig; vier begeleiders; speciaal voertuig; politie assistentie"
end

question :v_6, :type => :radio, :required => true do
  title "F.	Scoor risico voor de patient door anderen bewerkstelligd"
  option :a1, :value => 0, :description => "0.	niet aanwezig"

  option :a2, :value => 1, :description => "1.	intimideren; afhankelijk maken; ongewenste aandacht; benadelen"

  option :a3, :value => 2, :description => "2.	misbruik; geweld; oplichting; ernstig pesten/kwellen; prostitutie"

  option :a4, :value => 3, :description => "3.	ernstige marteling of verwonding; verkrachting; ernstige bedreiging via de media"

  option :a5, :value => 4, :description => "4.	dood; ernstige handicap; ernstige verwonding/trauma"
end
question :v_7, :type => :radio, :required => true do
  title "G.	Scoor behoefte voor risico management procedures"
  option :a1, :value => 0, :description => "0.	geen; of standaard procedure zoals het behandelplan"

  option :a2, :value => 1, :description => "1.	uitgebreidere procedure; zoals een standaard risico meting in een team"

  option :a3, :value => 2, :description => "2.	specialistisch klinisch risico management; relapse preventie of een andere specialistische therapie"

  option :a4, :value => 3, :description => "3.	Vereist gedwongen controle, zoals controleren op drugs bezit of gebruik; op wapens; controleren van bezoek, mails of telefoon"

  option :a5, :value => 4, :description => "4.	Invasieve  of intensieve controles, onderzoek, testen of vergelijkbare beperkende maatregelen"
end
  
text "* *Volgende stap *- in een forensische setting kunt u nu de standaard HoNOS scoren. In een andere setting kunt u een andere HoNOS versie kiezen (HoNOS65+, HoNOS-jeugd; HoNOS-LD; HoNOS-NAH)."
end
