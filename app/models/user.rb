class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  has_many :groups, foreign_key: :author_id, dependent: :destroy
  has_many :expenses, foreign_key: :author_id, dependent: :destroy

  # validates :name, presence: true, length: { maximum: 100 }, format: { with: /\A[\w\s.-]+\z/, message: "solo se permiten letras, números, espacios en blanco, guiones y puntos" }
  validates :name, presence: true, length: { maximum: 100 }, format: { with: /\A[a-zA-Z\s!@#$%^&*()_+{}\[\]:;'"\\|,.<>\/?]+\z/, message: "solo se permiten caracteres alfanuméricos, espacios en blanco y caracteres especiales" }

  validates :email, presence: true, length: { maximum: 150 }, uniqueness: true, email: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/, message: "Ingrese un correo electrónico válido" }, if: -> { email.present? }
  # presence: true: Esta validación garantiza que el campo no esté vacío.
  # length: { maximum: 150 }: Esta validación garantiza que el campo no exceda una longitud máxima de 150 caracteres.
  # uniqueness: true: Esta validación garantiza que el correo electrónico ingresado sea único en la base de datos.
  # email: true: Esta validación utiliza la gema email_validator para verificar que el correo electrónico tenga un formato válido.
  # format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/, message: "Ingrese un correo electrónico válido" }: Esta validación utiliza una expresión regular para verificar que el correo electrónico tenga un formato válido. El mensaje personalizado te informará al usuario si hay algún problema con el formato del correo electrónico.
  # if: -> { email.present? }: Esta validación se ejecutará solo si el correo electrónico está presente. Esto permite que otros validaciones relacionadas con la presencia del correo electrónico se ejecuten primero y evita que se muestren múltiples errores para el mismo campo.


  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # If I need more validations, I can add it with the following format:

  # validates :password, presence: true, length: { minimum: 6, too_short: "La contraseña debe tener al menos %{count} caracteres" }, format: { with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/, message: "La contraseña debe contener letras mayúsculas y minúsculas, números y caracteres especiales" }, confirmation: true, allow_nil: true
  
  # presence: true: Para asegurarse de que el campo no esté vacío.
  # length: { minimum: 6, too_short: "La contraseña debe tener al menos %{count} caracteres" }: Para asegurarse de que la longitud de la contraseña sea de al menos 6 caracteres.
  # format: { with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/, message: "La contraseña debe contener letras mayúsculas y minúsculas, números y caracteres especiales" }: Para asegurarse de que la contraseña contenga letras mayúsculas y minúsculas, números y caracteres especiales.
  # confirmation: true: Para requerir la confirmación de la contraseña en otro campo.
  # allow_nil: true: Para permitir que el campo esté vacío.


end
