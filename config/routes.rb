Rails.application.routes.draw do



  post 'payments/create', to: 'payments#create'
  get 'payments/success', to: 'payments#success'
  post 'payments/webhook', to: 'payments#webhook'
  
  resources :student_details

  
  resources :course_sub_labs do
    member do
      get 'reviewCodeWindow'
    end
    collection do 
      get 'codeViewShow'
      # get 'reviewCodeWindow'
    end
  end

  resources :course_labs do 
    collection do
      get 'arrange_course'
    end
  end
  
  resources :courses do
    collection do
      get 'getCourseData'
      get 'entroll_course'
      # get 'check_entrollment'
    end
    member do
      get 'change_student_course'
      post 'changed_course_student'
    end
  end
  
  resources :sectors do 
    collection do
      get "GetDataWithCourse"
    end
  end

  resources :admin_consultants do 
    collection do
      post 'create_consultantAdmin'
      get 'consultant_admins_datas'
      get 'get_branch_id'
    end
  end

  resources :consultant_admins do 
     member do
      post 'upload_image' 
      get 'getimage' 
    end

  end

  resources :student do
    member do
      post 'upload_image'
      post 'upload_image_cover' 
      get 'getimage' 
      get 'get_student_center'
      get 'profile_details'
      post 'Assign_student_course'
      get "allCourseForSelectedStudent"
      get 'allCourseForSelectedAdminStudent'

    end
    collection do
      get 'GetAllDataStudent'
    end
  end

  resources :admin do 
    collection do
      post 'createTittle'
      post 'updateTittleCourse'
      post'updateTittleName'
      post 'removeCourseTittle'
      delete 'deleteTittle'

    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # post 'createCourse' => 'admin#createCourse'

  # get 'getCourse' => 'admin#getCourse'

  # post 'createSubCourse' => 'admin#createSubCourse'

  # get 'getallLab/:id' => 'admin#getallLab'

  # get 'getSubAllLab/:id' => 'admin#getSubAllLab'

  # post 'createSubLab' => 'admin#createSubLab'


  post 'studentCode' => 'student#savestudentCode'


  post 'execute_query', to: 'admin#execute_query'

  get 'get_codeWindow_data/:id' => 'admin#get_codeWindow_data'

  post 'UpadteSubLabData/:id' => 'admin#UpadteSubLabData'

  # post 'createTittle' => 'admin#createTittle'

  get 'getTittleTable' => 'admin#getTittleTable'

  get 'getStudentSelectCourse/:id/:student_id' => 'admin#getStudentSelectCourse'

  get 'studentSelectCourseLab/:id/:user_id' => 'student#selectStudentCourseLab'

  post 'create_assign_student_labs' => 'student#create_assign_student_labs'

  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # post 'register', to: 'registrations#create'
  # post 'login', to: 'sessions#create'
  # get "getdata" => "posts#getData"
end
