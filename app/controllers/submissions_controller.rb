class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :set_cohort, only: [:index]
  before_action :set_task, only: [:create]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.where(task_id: (@cohort.tasks))
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)


    respond_to do |format|
      if @submission.save
        format.html { redirect_to task_path(@submission.task), notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        @comment = Comment.create(comment_params[:comment])

        format.html { redirect_to cohort_submissions_path(@submission.task.unit.cohort), notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_cohort
      @cohort = Cohort.find(params[:cohort_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:user_id, :task_id, :submission, :correctness, :reviewed, :percieved_points, :actual_points)
    end

    def comment_params
      params.require(:submission).permit(comment: [:submission_id, :user_id, :content])
    end
end
