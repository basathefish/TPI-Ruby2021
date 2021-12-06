module UsersHelper
    def isAdminUser?
        current_user.rol.name == "administracion"
    end
    
    def isConsuUser?
        current_user.rol.name == "consulta"
    end
    
    def isAsistUser?
        current_user.rol.name == "asistencia"
    end
end
