title "Voorbeeldvragenlijst"

# Regels die met een # beginnen zijn commentaarregels. Deze worden door Quby genegeerd.
#
# Een vragenlijst bevat vragen. Deze definieer je met ``question''. De structuur is als volgt:
#
# question :identificatie-code-voor-deze-vraag, :type => :soort do
#   ...
# end
#
# * :identificatiecode mag alles zijn zolang er geen spaties in staan, en moet uniek zijn binnen de vragenlijst.
# * :soort geeft aan wat voor vraag het is, op dit moment zijn mogelijk:
#   - :open    - een open vraag (textvak)
#   - :radio   - een multiple choice vraag waarbij een van de antwoorden moet worden gekozen.
#
# Op de plaats van de ... komt vervolgens een definitie van die vraag:
#
#   title "De titel van de vraag."
#   description "Uitleg bij de vraag, invulinstructies bijvoorbeeld."
#
# En in het geval van een :type => :radio vraag, worden de mogelijke keuzes als volgt aangegeven:
#
#   option :ident-voor-optie, :value => N, :description => "Text bij de optie."
# 
# Hierbij zijn de opties:
#
# * :ident-voor-optie is wederom een unieke code, in dit geval dient het uniek te zijn binnen de vraag.
# * :value => N   - N is een waarde (als getal) voor deze optie. Dit wordt later gebruikt bij het 
#                   genereren van rapporten. Alle waarden zijn mogelijk, ook niet-gehele getallen: 0.58
# * :description  - de tekst die bij de optie komt te staan in de weergave
#
# Standaard wordt per scherm 1 vraag gepresenteerd. Om meerdere vragen te
# groeperen is het commando ``panel'' te gebruiken:
#
#   panel "Titel" do
#     ...
#   end
#
# De titel van een panel is optioneel.
#
# Hieronder volgt een voorbeeldvraag uit de HonoSCA vragenlijst.

def foobar
  question :q02, :type => :radio do
    title "Asdf"
    option :a33, :value => 4, :description => "asdfjhjlksldf"
  end
end

question :q01, :type => :radio do
  title "Problemen met storend, antisociaal of agressief gedrag"
  description "<strong>Inclusief:</strong> gedrag dat gepaard gaat met een stoornis, zoals hyperkinesie, depressie, autisme, drugs of alcohol.<br/>
               <strong>Inclusief:</strong> fysieke of verbale agressie (bijv. duwen, slaan, vandalisme, plagen), of mishandeling of seksueel misbruik van andere kinderen.<br/>
               <strong>Inclusief:</strong> antisociaal gedrag (bijv. stelen, liegen, bedriegen) of oppositioneel gedrag (bijv. uitdagend gedrag, opstand tegen gezag, of driftbuien).<br/>
               <strong>Exclusief:</strong> hyperactiviteit, te scoren op schaal 2; spijbelen, te scoren op schaal 13; zelfbeschadiging, te scoren op schaal 3."

  option :a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
  option :a01, :value => 1, :description => "In geringe mate ruziemaken, veeleisend gedrag, overmatige irritatie, liegen, enzovoort."
  option :a02, :value => 2, :description => "Licht, maar duidelijk storend of antisociaal gedrag, geringe schade aan eigendommen, of agressie, of uitdagend gedrag."
  option :a03, :value => 3, :description => "Matig ernstig agressief of antisociaal gedrag, zoals vechten of voortdurend dreigen, of zeer oppositioneel, of ernstiger vernieling van eigendommen, of matig ernstige delicten."
  option :a04, :value => 4, :description => "Storend tijdens bijna alle activiteiten, of ten minsten één ernstige fysieke aanval op anderen of dieren, of ernstige vernieling van eigendommen."
  other :a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
end

foobar
foobar