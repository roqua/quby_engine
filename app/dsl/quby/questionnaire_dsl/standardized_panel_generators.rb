# rubocop:disable LineLength

module Quby
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
* U kunt uw antwoorden afdrukken door op de knop &#39;Print Antwoorden&#39; te klikken.
* Sla de antwoorden op door op de &#39;Klaar&#39;-knop onderaan te klikken. Daarna kunt u uw antwoorden niet meer wijzigen."
        end
      end

      def informal_end_panel
        panel do
          text "*Bedankt voor het invullen van deze vragenlijst.*<br>
* Je kan je antwoorden afdrukken door op de knop &#39;Print Antwoorden&#39; te klikken.
* Sla de antwoorden op door op de &#39;Klaar&#39;-knop onderaan te klikken. Daarna kun je je antwoorden niet meer wijzigen."
        end
      end
    end
  end
end
