title "Dependency Test Lijst"

panel "Eerste panel" do
  question :q01, :type => :string do
    title "Eerste vraag"
    validates :regexp => /oo/
  end
end

panel "Tweede panel" do
  question :q02, :type => :string do
    title "Tweede vraag"
    depends_on :q01, :matches => /oo/
  end
end

