# frozen_string_literal: true

# rubocop:disable LineLength

module Quby
  module Questionnaires
    module DSL
      module StandardizedPanelGenerators
        def start_panel
          panel do
            text "Welkom bij deze vragenlijst"
          end
        end

        def end_panel
          panel do
            text "*Bedankt voor het invullen van deze vragenlijst.*<br>
  * U kunt uw antwoorden downloaden door op de knop &#39;Download als PDF&#39; te klikken. Dit bestand is ook geschikt om af te drukken.<br>
  * Sla de antwoorden op door op de &#39;Klaar&#39;-knop onderaan te klikken. Daarna kunt u uw antwoorden niet meer wijzigen."
          end
        end

        def informal_end_panel
          panel do
            text "*Bedankt voor het invullen van deze vragenlijst.*<br>
  * Je kan je antwoorden downloaden door op de knop &#39;Download als PDF&#39; te klikken. Dit bestand is ook geschikt om af te drukken.<br>
  * Sla de antwoorden op door op de &#39;Klaar&#39;-knop onderaan te klikken. Daarna kun je je antwoorden niet meer wijzigen."
          end
        end
      end
    end
  end
end
