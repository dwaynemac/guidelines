class Aktion < ActiveRecord::Base
  belongs_to :goal
  belongs_to :who, :class_name => "Person"

  validates_presence_of :goal, :begins_on, :ends_on

  validates_numericality_of :progress, :less_than_or_equal_to => 100, :greater_than_or_equal_to => 0
  validates_inclusion_of :status, :in => %W(waiting in_progress finished)

  named_scope :overdue, { :conditions => ["status<>'finished' AND due_on < ?",Time.zone.today]}
  def overdue?
    (!self.completed? && (self.due_on < Time.zone.today))
  end
  def completed?
    self.status == "finished"
  end

  before_save :set_completed
  def set_completed
def set_completed
    if self.status_changed?
      self.progress= 100 if self.status == 'finished'
    end
    if self.progress_changed?
      if self.progress == 100
        self.status = "finished"
      end
    end
  end
  end
end
