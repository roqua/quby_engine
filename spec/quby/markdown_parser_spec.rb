require 'spec_helper'

module Quby
  describe MarkdownParser do
    it 'handles list elements' do
      source = "* one\n* two"
      output = "<ul>\n  <li>one</li>\n  <li>two</li>\n</ul>"
      expect_markdown_transformation(source, output)
    end

    it 'it handles strong list elements' do
      source = "* **one**\n* two"
      output = "<ul>\n  <li><strong>one</strong></li>\n  <li>two</li>\n</ul>"
      expect_markdown_transformation(source, output)
    end

    it 'handles inline attributes' do
      source = "<span style=\"color:#FF0000\">LET OP:</span>"
      output = "<p><span style=\"color:#FF0000\">LET OP:</span></p>"
      expect_markdown_transformation(source, output)
    end

    it 'handles complex lists' do
      source = "*Uitvoering*<br>
  **Instrueer de revalidant om de paretische arm naast het hoofd te brengen in de flexiesynergie dat wil zeggen:**

* **90º abductie**
* **volledige exorotatie van de schouder**
* **90º flexie met volledige supinatie**<br><br>
  *<span style=\"color:#FF0000\">LET OP:<br> Bij twijfel of revalidant elevatie en retractie uit kan voeren mag je dit afzonderlijk meten. Revalidant moet hiervoor wel een deel van de beweging kunnen maken.</span>*"

      expect_markdown_transformation(source, "")
    end

    def expect_markdown_transformation(source, output)
      expect(described_class.new(source).to_html).to eq(output)
    end
  end
end
