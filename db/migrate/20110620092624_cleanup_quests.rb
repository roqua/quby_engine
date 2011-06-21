class CleanupQuests < ActiveRecord::Migration
  def self.up

    ["HoNOS gezonde controles",
    "MANSA controlegroep",
    "OQ-45 controlegroep",
    "WegweisTevredenheidsvragenlijst",
    "adviesrelevantie",
    "dependency_test",
    "help",
    "heuristische-evaluatie",
    "adhd_kindertijd"].each do |key|
      q = Questionnaire.find_by_key key
      if q
        q.destroy
      end
    end

    ["phamous_04_medicatie_2",
    "phamous_04_medicatie_3",
    "phamous_04_medicatie_4",
    "phamous_08_panss_verkort",
    "keekring",
    "phamous_14_beleid",
    "phamous_10_sra_bulk"].each do |key|
      q = Questionnaire.find_by_key key
      if q
        q.answers.delete_all
        q.destroy
      end
    end
  end

  def self.down
  end
end
