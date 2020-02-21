import struct Foundation.Date
import struct Foundation.UUID

public struct DatabaseSchema {
    public enum Action {
        case create
        case update
        case delete
    }
    
    public indirect enum DataType {
        case json
        
        public static var int: DataType {
            return .int64
        }
        case int8
        case int16
        case int32
        case int64
        
        public static var uint: DataType {
            return .uint64
        }
        case uint8
        case uint16
        case uint32
        case uint64
        
        
        case bool
        
        public struct Enum {
            public var name: String
            public var cases: [String]
        }
        case `enum`(Enum)
        case string
        
        case time
        case date
        case datetime
        
        case float
        case double
        case data
        case uuid

        case array(of: DataType)
        case custom(Any)
    }
    
    public enum FieldConstraint {
        public static func references(
            _ schema: String,
            _ field: String,
            onDelete: DatabaseSchema.Constraint.ForeignKeyAction = .noAction,
            onUpdate: DatabaseSchema.Constraint.ForeignKeyAction = .noAction
        ) -> Self {
            .foreignKey(
                field: .string(schema: schema, field: field),
                onDelete: onDelete,
                onUpdate: onUpdate
            )
        }

        case required
        case identifier(auto: Bool)
        case foreignKey(
            field: ForeignFieldName,
            onDelete: Constraint.ForeignKeyAction,
            onUpdate: Constraint.ForeignKeyAction
        )
        case custom(Any)
    }
    
    public enum Constraint {
        case unique(fields: [FieldName])
        case foreignKey(fields: [FieldName], foreignSchema: String, foreignFields: [FieldName], onDelete: ForeignKeyAction, onUpdate: ForeignKeyAction)
        case custom(Any)

        public enum ForeignKeyAction {
            case noAction
            case restrict
            case cascade
            case setNull
            case setDefault
        }
    }
    
    public enum FieldDefinition {
        case definition(
            name: FieldName,
            dataType: DataType,
            constraints: [FieldConstraint]
        )
        case custom(Any)
    }

    public enum FieldUpdate {
        case dataType(name: FieldName, dataType: DataType)
        case custom(Any)
    }
    
    public enum FieldName {
        case key(FieldKey)
        case custom(Any)
    }

    public enum ForeignFieldName {
        case string(schema: String, field: String)
        case custom(schema: Any, field: Any)
    }

    public var action: Action
    public var schema: String
    public var createFields: [FieldDefinition]
    public var updateFields: [FieldUpdate]
    public var deleteFields: [FieldName]
    public var constraints: [Constraint]
    
    public init(schema: String) {
        self.action = .create
        self.schema = schema
        self.createFields = []
        self.updateFields = []
        self.deleteFields = []
        self.constraints = []
    }
}
